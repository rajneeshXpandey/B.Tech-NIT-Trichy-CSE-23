from collections import defaultdict

from src.main import q_0, q_f, TrainingData


class InputParser(object):
    def __init__(self, filename):
        self.filename = filename

    def __get_only_sentences(self):
        file = open(self.filename)
        return [line for line in file if line != '\n']

    def __get_all_sentences(self):
        return [line for line in open(self.filename)]

    def get_tags_in_sequence(self):
        tags_in_order = [q_0]
        for row in self.__get_all_sentences():
            row_array = row.split('\t')
            if len(row_array) == 1:
                tags_in_order.append(q_f)
                tags_in_order.append(q_0)
            else:
                tags_in_order.append(row_array[2].strip())
        return tags_in_order[:-1]  # in order to remove the unnecessary q_0 at the end

    def build_training_data(self):
        train_data = defaultdict(dict)
        vocabulary = set()
        for sentence in self.__get_only_sentences():
            position, word, tag = sentence.split('\t')
            word = word.lower().strip()
            tag = tag.strip()
            vocabulary.add(word)
            train_data[tag][word] = train_data.get(tag, {}).get(word, 0) + 1
        return TrainingData(train_data, list(vocabulary))