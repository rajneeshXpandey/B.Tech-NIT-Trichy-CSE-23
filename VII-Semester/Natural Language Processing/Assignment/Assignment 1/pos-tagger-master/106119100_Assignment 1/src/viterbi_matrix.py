from src.matrix import Matrix


class ViterbiMatrix(Matrix):
    def __init__(self, matrix, input_sequence):
        super().__init__(matrix)
        self.input_sequence = input_sequence

    def __get_tuple_with_max_value_in_last_column(self):
        return max([self.matrix[tag][self.input_sequence[-1]] for tag in self.matrix.keys()], key=lambda tup: tup[0])

    def get_best_tag_sequence(self):
        best_tag_sequence = []
        tag = self.__get_tuple_with_max_value_in_last_column()[1]
        for word in reversed(self.input_sequence[1:]):
            tag = self.matrix[tag][word][1]
            best_tag_sequence.append(tag)
        return list(reversed(best_tag_sequence))