from src.main import d
from src.matrix import Matrix


class TransitionMatrix(Matrix):
    def __init__(self, matrix, tag_bigram_model, start, end, tag_count_in_sequence):
        super().__init__(matrix)
        self.tag_bigram_count = tag_bigram_model
        self.start = start
        self.end = end
        self.tag_count_in_sequence = tag_count_in_sequence

    def __number_of_times_tag_occurs(self, tag):
        return self.tag_count_in_sequence.get(tag, 0)

    def __number_of_occurring_bigrams_starting_with(self, tag_a):
        return self.start.get(tag_a, 0)

    def __number_of_occurring_bigrams_ending_with(self, tag_a):
        return self.end.get(tag_a, 0)

    def __number_of_bigram_combinations(self):
        return len(self.tag_bigram_count) ** 2

    def get_smoothed_data(self, tag_a, tag_b):
        # return self.matrix[tag_a][tag_b]
        times_tag_occurs = self.__number_of_times_tag_occurs(tag_a)
        term_a = max((self.tag_bigram_count[tag_a][tag_b] - d), 0) / times_tag_occurs
        lambda_parameter = d / times_tag_occurs * self.__number_of_occurring_bigrams_starting_with(tag_a)
        p_continuation = self.__number_of_occurring_bigrams_ending_with(tag_a) / self.__number_of_bigram_combinations()

        return term_a + (lambda_parameter * p_continuation)