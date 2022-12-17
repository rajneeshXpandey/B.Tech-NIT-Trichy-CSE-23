from src.main import q_0, q_f, training_data, unk_word
from src.matrix import Matrix
from src.transition_matrix import TransitionMatrix


class MatrixFactory(object):
    def __init__(self, data, all_tags, tags_in_training_data):
        self.training_data = data
        self.unique_tags = all_tags
        self.tags_in_sequence = tags_in_training_data

    def __build_dictionary_of_dictionary(self):
        unique_tags_with_start_of_sentence = [q_0] + self.unique_tags
        unique_tags_with_end_of_sentence = self.unique_tags + [q_f]
        return dict(((tag_a, dict((tag_b, 0) for tag_b in unique_tags_with_end_of_sentence)) for tag_a in
                     unique_tags_with_start_of_sentence))

    def __get_tags_bigram_count(self):
        tag_bi_gram_count = self.__build_dictionary_of_dictionary()
        for i in range(len(self.tags_in_sequence) - 1):
            if self.tags_in_sequence[i + 1] != q_0:
                tag_bi_gram_count[self.tags_in_sequence[i]][self.tags_in_sequence[i + 1]] += 1
        return tag_bi_gram_count

    def __get_tag_count(self, tag_a):
        return self.tags_in_sequence.count(tag_a)

    def __get_bigram_start_end_matrix(self):
        tag_bigram_count = self.__get_tags_bigram_count()
        bigram_starts_with_tag_matrix = {}
        bigram_ends_with_tag_matrix = {}
        for tag in training_data.get_unique_tags():
            bigram_starts_with_tag_matrix[tag] = len(
                [tag_b for tag_b, count in tag_bigram_count[tag].items() if count > 0])
            bigram_ends_with_tag_matrix[tag] = len([tag_two_count for tag_one, tag_two_count in tag_bigram_count.items()
                                                    if tag_two_count.get(tag, 0) > 0])
        return bigram_starts_with_tag_matrix, bigram_ends_with_tag_matrix

    def __get_tag_count_in_sequence(self):
        tag_count_in_sequence = dict()
        for tag in [q_0] + self.unique_tags + [q_f]:
            tag_count_in_sequence[tag] = self.tags_in_sequence.count(tag)
        return  tag_count_in_sequence

    def build_transition_matrix(self):
        start_mat, end_mat = self.__get_bigram_start_end_matrix()
        tag_count_in_sequence = self.__get_tag_count_in_sequence()
        matrix = self.__build_dictionary_of_dictionary()
        tags_bigram_count = self.__get_tags_bigram_count()
        for tag_a, tag_b_count in tags_bigram_count.items():
            for tag_b, count in tag_b_count.items():
                matrix[tag_a][tag_b] = count / self.__get_tag_count(tag_a)

        return TransitionMatrix(matrix, tags_bigram_count, start_mat, end_mat, tag_count_in_sequence)


    def build_emission_matrix(self):
        emission_probability_of_unk_word = 1 / len(self.training_data.get_unique_tags())
        matrix = dict(self.training_data.matrix)
        for tag, word_count in self.training_data.items():
            for word in word_count.keys():
                matrix[tag][word] = self.training_data[tag][word] / self.__get_tag_count(tag)
            matrix[tag][unk_word] = emission_probability_of_unk_word
        return Matrix(matrix)


class VectorFactory(MatrixFactory):
    def __init__(self, data, all_tags, tags_in_training_data):
        super().__init__(data, all_tags, tags_in_training_data)

    def build_unigram_tag_probability(self):
        vector = dict((tag, 0) for tag in self.unique_tags)
        number_of_tags = len(self.tags_in_sequence)
        for tag in self.unique_tags:
            vector[tag] = self.tags_in_sequence.count(tag) / number_of_tags
        return Matrix(vector)