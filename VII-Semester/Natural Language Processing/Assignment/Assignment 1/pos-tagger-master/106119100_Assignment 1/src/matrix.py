class Matrix(object):
    def __init__(self, matrix):
        self.matrix = matrix

    def __getitem__(self, item):
        return self.matrix[item]

    def items(self):
        return self.matrix.items()