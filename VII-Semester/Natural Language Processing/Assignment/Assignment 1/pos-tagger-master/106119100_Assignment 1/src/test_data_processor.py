from src.main import q_f, unk_word


class TestDataPreProcessor(object):
    def __init__(self, filename, that_training_data):
        self.filename = filename
        self.training_data = that_training_data

    @staticmethod
    def __reset(sentence, sentences):
        sentence.append(q_f)
        sentences.append(sentence)
        return []

    def convert_to_list_of_tokenized_sentences(self):
        sentences_for_output = []
        sentences_for_test_data = []
        sentence_for_output = []
        sentence_for_test_data = []
        for row in open(self.filename):
            row_array = row.split('\t')
            if len(row_array) == 1:
                sentence_for_output = self.__reset(sentence_for_output, sentences_for_output)
                sentence_for_test_data = self.__reset(sentence_for_test_data, sentences_for_test_data)
            else:
                word = row_array[1].strip()
                sentence_for_output.append(word)
                sentence_for_test_data.append(unk_word if self.training_data.is_unknown_word(word) else word)
        return sentences_for_test_data, sentences_for_output


class TestDataOutput(object):
    def __init__(self, sentences):
        self.sentences = sentences

    @staticmethod
    def write_to_file(filename, str_to_save_to_file):
        file = open(filename, 'w')
        file.write(str_to_save_to_file)
        file.close()

    def save_with_tags(self, pos_tags_per_sentence, filename):
        str_to_save_to_file = ''
        for i in range(len(pos_tags_per_sentence)):
            for j in range(len(pos_tags_per_sentence[i])):
                str_to_save_to_file += str.format('{}\t{}\t{}\n', j + 1, self.sentences[i][j],
                                                  pos_tags_per_sentence[i][j])
            str_to_save_to_file += '\n'
        self.write_to_file(filename, str_to_save_to_file)