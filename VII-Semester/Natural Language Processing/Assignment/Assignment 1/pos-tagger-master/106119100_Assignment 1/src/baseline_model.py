class BaselineClassifier(object):
    def __init__(self, that_training_data):
        self.training_data = that_training_data

    def classify(self, sentences):
        tag_per_sentence = []
        for sentence in sentences:
            tags = []
            for word in sentence:
                tag_word_count = [(tag, word_count[word]) for tag, word_count in self.training_data.matrix.items() if
                                  word_count.get(word, 0) != 0]
                if len(tag_word_count) > 1:
                    tags.append(max(tag_word_count, key=lambda tup: tup[1])[0])
                else:
                    tags.append('')
            tag_per_sentence.append(tags)
        return tag_per_sentence