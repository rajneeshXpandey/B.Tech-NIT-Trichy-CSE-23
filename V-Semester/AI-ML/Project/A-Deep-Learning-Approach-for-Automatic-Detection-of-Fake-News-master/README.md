# A Deep Learning Approach for Automatic Detection of Fake News
Research Paper Published at ICON 2019, indexed in ACL Anthology by **Tanik Saikh**, **Arkadipta De**, **Asif Ekbal**, **Pushpak Bhattacharyya**

[![Others](https://img.shields.io/badge/Keras-1.8.1-red)](https://keras.io)
[![Others](https://img.shields.io/badge/Tensorflow-(Stable)1.11.0-orange)](https://www.tensorflow.org/)
[![Others](https://img.shields.io/badge/Python-3.6-green)](https://www.python.org/)

# Proceedings
**16th International Conference on Natural Language Processing 2021** - https://ltrc.iiit.ac.in/icon2019/icon2019proceedings.pdf

# Introduction
Fake news detection is a very prominent and
essential task in the field of journalism. This
challenging problem is seen so far in the field
of politics, but it could be even more challenging when it is to be determined in the
multi-domain platform. In this paper, we
propose two effective models based on deep
learning for solving fake news detection problem in online news contents of multiple domains. We evaluate our techniques on the
two recently released datasets, namely FakeNews AMT and Celebrity for fake news detection. The proposed systems yield encouraging
performance, outperforming the current handcrafted feature engineering based state-of-theart system with a significant margin of 3.08%
and 9.3% by the two models, respectively. In
order to exploit the datasets, available for the
related tasks, we perform cross-domain analysis (i.e. model trained on FakeNews AMT and
tested on Celebrity and vice versa) to explore
the applicability of our systems across the domains.

# Result
|Dataset|System Model|Test Accuracy(%)|
|---|---|---|
|FakeNews AMT|Proposed Model1|77.08|
|FakeNews AMT|Proposed Model2|83.33|
|FakeNews AMT|(Perez-Rosas et al. 2018) Linear SVM|74|
|Celebrity|Proposed Model1|76.53|
|Celebrity|Proposed Model2|79|
|Celebrity|(Perez-Rosas et al. 2018) Linear SVM|76|

# Reads
Read the paper at : https://arxiv.org/abs/2005.04938

# Citation
For Research Puropose cite the following:
```
@article{DBLP:journals/corr/abs-2005-04938,
  author    = {Tanik Saikh and
               Arkadipta De and
               Asif Ekbal and
               Pushpak Bhattacharyya},
  title     = {A Deep Learning Approach for Automatic Detection of Fake News},
  journal   = {CoRR},
  volume    = {abs/2005.04938},
  year      = {2020},
  url       = {https://arxiv.org/abs/2005.04938},
  archivePrefix = {arXiv},
  eprint    = {2005.04938},
  timestamp = {Thu, 14 May 2020 16:56:02 +0200},
  biburl    = {https://dblp.org/rec/journals/corr/abs-2005-04938.bib},
  bibsource = {dblp computer science bibliography, https://dblp.org}
}
```
