from sklearn.model_selection import train_test_split

from src.baseline_model import BaselineClassifier
from src.matrix import Matrix
from src.matrix_factory import MatrixFactory
from src.parser import InputParser
from src.test_data_processor import TestDataPreProcessor, TestDataOutput
from src.viterbi import Viterbi

q_0 = '-'
q_f = '\n'

unk_word = '<UNK>'

d = 0.75

data_set_filename = 'data/berp-POS-training.txt'
training_data_filename = 'data/training_data.txt'
# test_data_filename = '../data/assgn2-test-set.txt'
# output_filename = '../data/sulegaon-nikhil-assgn2-test-output.txt'
test_data_filename = 'data/test-data.txt'
output_filename = 'data/out.txt'


class TrainingData(Matrix):
    def __init__(self, matrix, vocabulary_of_corpus):
        super().__init__(matrix)
        self.vocabulary_of_corpus = vocabulary_of_corpus

    def get_unique_tags(self):
        return list(self.matrix.keys())

    def is_unknown_word(self, word):
        return word not in self.vocabulary_of_corpus


def split_training_data_to_test_data():
    data_set = []
    sentence = []
    for line in open(data_set_filename):
        if line == '\n':
            data_set.append(sentence)
            sentence = []
        else:
            sentence.append(line)

    training_set, test_set = train_test_split(data_set, test_size=0.1, random_state=132)

    TestDataOutput.write_to_file(training_data_filename, str.join('\n', [str.join('', sent) for sent in training_set]) + '\n')
    TestDataOutput.write_to_file(test_data_filename, str.join('\n', [str.join('', sent) for sent in test_set]) + '\n')


def perform_baseline_classification():
    global processor, test_data_sentences, output_sentences
    processor = TestDataPreProcessor(test_data_filename, training_data)
    test_data_sentences, output_sentences = processor.convert_to_list_of_tokenized_sentences()
    classifier = BaselineClassifier(training_data)
    pos_tags_per_sentence = classifier.classify(test_data_sentences)
    TestDataOutput(output_sentences).save_with_tags(pos_tags_per_sentence, output_filename)


if __name__ == '__main__':
    split_training_data_to_test_data()

    parser = InputParser(training_data_filename)
    training_data = parser.build_training_data()

    # perform_baseline_classification()

    unique_tags = training_data.get_unique_tags()
    tags_in_sequence = parser.get_tags_in_sequence()

    processor = TestDataPreProcessor(test_data_filename, training_data)
    test_data_sentences, output_sentences = processor.convert_to_list_of_tokenized_sentences()

    factory = MatrixFactory(training_data, unique_tags, tags_in_sequence)
    transition_matrix = factory.build_transition_matrix()
    emission_matrix = factory.build_emission_matrix()

    viterbi = Viterbi(transition_matrix, emission_matrix, unique_tags, training_data)
    matrices = viterbi.run(test_data_sentences)

    pos_tags_of_sentences = [matrix.get_best_tag_sequence() for matrix in matrices]

    TestDataOutput(output_sentences).save_with_tags(pos_tags_of_sentences, output_filename)
