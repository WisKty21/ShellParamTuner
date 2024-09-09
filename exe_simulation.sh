#!/bin/bash

# headerディレクトリからPARAMの値を取得
PARAM=$(grep 'define PARAM' header/math_parameters.h | awk '{print $3}' | sed 's/[^0-9.]*//g')

# PARAMの0.00から1.00まで0.01刻みでPARAMの値を変更しながらプログラムを実行
PARAM_MIN=0.00  # PARAMの最小値を0.00に設定
B_MIN=$(printf "%.2f" $(echo "10 * $PARAM_MIN" | bc -l))  # Bの最小値を計算
B_MAX=$(printf "%.2f" $(echo "10 * 1.00" | bc -l))  # Bの最大値を計算

# パラメータBの範囲フォルダを作成
RANGE_FOLDER="B=$B_MIN-$B_MAX"
mkdir -p "$RANGE_FOLDER"

for i in {0..100}; do
  PARAM_TMP=$(printf "%.2f" $(echo "$PARAM_MIN + $i / 100" | bc -l))  # PARAMの値を計算
  B_VALUE=$(printf "%.2f" $(echo "10 * $PARAM_TMP" | bc -l))  # Bの値を計算
  
  # パラメータの値が名前に入ったフォルダを作成
  FOLDER_NAME="$RANGE_FOLDER/B=$B_VALUE"
  mkdir -p "$FOLDER_NAME"
  
  # headerファイルの書き換え
  echo -e "#ifndef MATH_PARAMETERS_H\n#define MATH_PARAMETERS_H\n\n#define PARAM $PARAM_TMP\n\n#define B (10 * PARAM)\n\n#endif // MATH_PARAMETERS_H" > header/math_parameters.h
  
  # C言語のプログラムをコンパイル
  gcc -O3 prog.c -o simulation
  
  # コンパイルしたプログラムを実行
  ./simulation $FOLDER_NAME
done
