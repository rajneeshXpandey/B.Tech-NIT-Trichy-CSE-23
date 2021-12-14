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
import tensorflow as tf
import tensorflow_hub as hub
import keras
import keras.layers as layers
from keras.engine.topology import Layer
from sklearn.model_selection import train_test_split
from keras.models import Model, Input
from keras.layers import MaxPool1D, MaxPool2D, Dropout, Dense, LSTM, GRU, Bidirectional, concatenate, Multiply, Subtract
from keras.utils import to_categorical

elmo_model = hub.Module("https://tfhub.dev/google/elmo/2", trainable=True)

#Inputs_ELMO
input_titles = layers.Input(shape=(1,), dtype=tf.string)
input_contents = layers.Input(shape=(1,), dtype=tf.string)

sess = tf.Session()
sess.run(tf.global_variables_initializer())
sess.run(tf.tables_initializer())

#ELMO Model
def ElmoEmbedding(x):
    return elmo_model(tf.squeeze(tf.cast(x, tf.string)), signature="default", as_dict=True)["default"]

def Classifier_with_Elmo(input_t,input_c):
    embedding_t = layers.Lambda(ElmoEmbedding, output_shape=(1024,))(input_t)
    embedding_c = layers.Lambda(ElmoEmbedding, output_shape=(1024,))(input_c)
    z = concatenate([embedding_t,embedding_c])
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
    output = layers.Dense(2, activation='softmax')(z)
    model = Model(inputs=[input_t,input_c], outputs = output)
    model.summary()
    return model

def compile_and_train(model, num_epochs): 
    model.compile(optimizer= 'adam', loss= 'categorical_crossentropy', metrics=['acc']) 
    history = model.fit([train_x_title,train_x_content], train_label, batch_size=32, epochs=num_epochs)
    return history

Classifier_Model = Classifier_with_Elmo(input_titles,input_contents)

#compile_and_train(Classifier_Model, num_epochs=10)
