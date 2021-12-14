"""
Author : Arkadipta De
Paper : A Deep Learning Approach for Automatic Detection of Fake News
        by Tanik Saikh, Arkadipta De, Asif Ekbal, Pushpak Bhattacharyya
Link : https://arxiv.org/abs/2005.04938
MIT License Protected (Using for Research Purpose without Citation is punishable offence)
"""

import re
import os
import numpy as np
import pandas as pd
import keras
import Attention
from tensorflow.keras.layers import Layer
from tensorflow.keras import Input
#from keras.engine.topology import Layer, Input
from sklearn.model_selection import train_test_split
from keras.models import Model, Input
from keras.layers import Dropout, Dense, LSTM, GRU, Bidirectional, concatenate, Multiply, Subtract
from keras.utils import to_categorical
from keras import backend as K
from keras import initializers

# Define Maximum Title Length of The Dataset
Max_Title_Length = 50
# Define Maximum Content Length of The Dataset
Max_Content_Length = 155 
# Define Embedding Vector Size for each word embedding (e.g 300 if you use FastText Embeddings) 
vector_size = 100 

input_title = Input(shape=(Max_Title_Length, vector_size,), name='input_title')
input_content = Input(shape=(Max_Content_Length, vector_size, ), name='input_content')

def Classifier(input_title, input_content):
    #x = Bidirectional(GRU(units = 100, return_sequences = True, kernel_initializer = keras.initializers.lecun_normal(seed = None), unit_forget_bias = True))(input_title)
    x = Bidirectional(GRU(100, return_sequences=True))(input_title)
    x_attention = Attention.Hierarchical_Attention(100)(x)
    #y = Bidirectional(LSTM(units = 100, return_sequences = True, kernel_initializer = keras.initializers.lecun_normal(seed = None), unit_forget_bias = True))(input_content)
    y = Bidirectional(GRU(100, return_sequences=True))(input_content)
    y_attention = Attention.Hierarchical_Attention(100)(y)
    z = concatenate([x_attention,y_attention])
    z = Dense(units = 512, activation = 'relu')(z)
    z = Dropout(0.2)(z)
    z = Dense(units = 256, activation = 'relu')(z)
    z = Dropout(0.2)(z)
    z = Dense(units = 128, activation = 'relu')(z)
    z = Dropout(0.2)(z)
    z = Dense(units = 50, activation = 'relu')(z)
    z = Dropout(0.2)(z)
    z = Dense(units = 10, activation = 'relu')(z)
    z = Dropout(0.2)(z)
    output = Dense(units = 2, activation = 'softmax')(z)
    model = Model(inputs = [input_title, input_content], outputs = output)
    model.summary()
    return model

def compile_and_train(model, num_epochs): 
    model.compile(optimizer= 'adam', loss= 'categorical_crossentropy', metrics=['acc']) 
    history = model.fit([train_x_title,train_x_content], train_label, batch_size=32, epochs=num_epochs)
    return history

print(input_title)
print(input_content)

Classifier_Model = Classifier(input_title,input_content)
#train_x_title = ["PLOT T IST IN 'FATHER-SON' MOVIEMAKER MYSTERY"]
#train_x_content = ["Forget 'Pearl Harbor' – Hollywood is buzzing about a true-life scandal involving the paternity of the $140 million blockbuster's director, Michael Bay."]
#train_label = ["Legit"]
#compile_and_train(Classifier_Model, num_epochs = 10)
