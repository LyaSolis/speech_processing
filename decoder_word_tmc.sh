#==============================================================
# This decoding script produces time stamps on a word level.
#==============================================================

. cmd.sh
. run.sh

online2-wav-nnet3-latgen-faster \
      --online=false \
      --do-endpointing=false \
      --frame-subsampling-factor=3 \
      --config=exp/tdnn_7b_chain_online/conf/online.conf \
      --max-active=7000 \
      --beam=15.0 \
      --lattice-beam=6.0 \
      --feature-type=mfcc \
      --acoustic-scale=1.0 \
               --mfcc-config=conf/mfcc_hires.conf \
      --word-symbol-table=exp/tdnn_7b_chain_online/graph_pp/words.txt \
      exp/tdnn_7b_chain_online/final.mdl \
      exp/tdnn_7b_chain_online/graph_pp/HCLG.fst \
               'ark:echo utterance-id2 utterance-id2|' \
               "scp:echo utterance-id2 sample.wav |" \
                 ark:| lattice-1best ark:- ark: | \
                 lattice-align-words exp/tdnn_7b_chain_online/graph_pp/phones/word_boundary.int exp/tdnn_7b_chain_online/final.mdl ark:- ark:- | \
                 nbest-to-ctm --frame-shift=0.03 --print-silence=false ark:- - | \
                 utils/int2sym.pl -f 5 exp/tdnn_7b_chain_online/graph_pp/words.txt > sample.txt

