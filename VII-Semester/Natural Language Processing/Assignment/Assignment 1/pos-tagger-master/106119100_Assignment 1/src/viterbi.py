from src.main import q_0, q_f
from src.viterbi_matrix import ViterbiMatrix


class Viterbi(object):
    def __init__(self, transition_probability, emission_probability, all_tags, data):
        self.transition_matrix = transition_probability
        self.emission_matrix = emission_probability
        self.all_tags = all_tags
        self.training_data = data

    def __get_max_value_tag_tuple(self, all_viterbi_values):
        max_viterbi_value = max(all_viterbi_values)
        tag = self.all_tags[all_viterbi_values.index(max_viterbi_value)]
        return max_viterbi_value, tag

    def run(self, sentences):
        viterbi_matrices = []
        for tokenized_sentence in sentences:
            viterbi_matrix = dict((tag, dict(tuple())) for tag in self.all_tags)
            first_word = tokenized_sentence[0]
            for tag in self.all_tags:
                viterbi_matrix[tag][first_word] = (self.emission_matrix[tag].get(first_word, 0) *
                                                   self.transition_matrix.get_smoothed_data(q_0, tag), q_0)

            i = 1
            for word in tokenized_sentence[1:-1]:
                for tag in self.all_tags:
                    all_viterbi_values = [viterbi_matrix[previous_tag][tokenized_sentence[i - 1]][0] *
                                          self.emission_matrix[tag].get(word, 0) *
                                          self.transition_matrix.get_smoothed_data(previous_tag, tag) for previous_tag
                                          in self.all_tags]
                    viterbi_matrix[tag][word] = self.__get_max_value_tag_tuple(all_viterbi_values)
                i += 1

            last_word = tokenized_sentence[-1]
            for tag in self.all_tags:
                all_viterbi_values = [viterbi_matrix[previous_tag][tokenized_sentence[-2]][0] *
                                      self.transition_matrix.get_smoothed_data(previous_tag, q_f) for previous_tag
                                      in self.all_tags]
                viterbi_matrix[tag][last_word] = self.__get_max_value_tag_tuple(all_viterbi_values)

            viterbi_matrices.append(ViterbiMatrix(viterbi_matrix, tokenized_sentence))
        return viterbi_matrices