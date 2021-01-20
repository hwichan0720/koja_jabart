#!/usr/bin/env -eu
GPU=$1
ROOT=../..
PRETRAINED_MODEL=$ROOT/pretrained_bart/japanese_bart_base_1.1/trim/ja_bart_base.pt
fairseq=/fairseq
BIN=$ROOT/data/ja-ko

CUDA_VISIBLE_DEVICES=$GPU fairseq-train ../../data/ja-ko \
    --arch bart_base \
    --restore-file $PRETRAINED_MODEL \
    --task translation_from_pretrained_bart \
    --source-lang ja --target-lang ko \
    --seed 1 \
    --keep-last-epochs 10 \
    --optimizer adam \
    --adam-betas '(0.9, 0.98)' \
    --clip-norm 0.0 \
    --lr-scheduler inverse_sqrt \
    --warmup-init-lr 1e-07 \
    --warmup-updates 4000 \
    --lr 0.0005 \
    --min-lr 1e-09 \
    --update-freq 8 \
    --dropout 0.1 \
    --weight-decay 0.0 \
    --share-all-embeddings \
    --criterion label_smoothed_cross_entropy \
    --label-smoothing 0.1 \
    --max-tokens 4098 \
    --max-update 50000 \
    --reset-optimizer \
    --reset-meters \
    --reset-dataloader \
    --reset-lr-scheduler \
    --eval-bleu \
    --eval-bleu-remove-bpe sentencepiece \
    --best-checkpoint-metric bleu \
    --maximize-best-checkpoint-metric \
    --patience 10