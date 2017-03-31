#!/bin/bash

declare -a DatasetsNames=(
  'BreastCancerWisconsinDownsampled'
  'CarEvaluation'
  'CreditApprovalDownsampledFurther'
  'GermanCreditDownsampledFurther'
  'IonosphereDownsampledFurther'
  'MammographicMassDownsampled'
  'MushroomDownsampled'
  'NurseryDownsampledFurther'
  'SpectHeartDownsampledFurther'
  'TicTacToe'
  'VehicleDownsampledFurther'
  'WineDownsampled'
)

for i in "${!DatasetsNames[@]}"
do
	Src/gen Original/UCI/${DatasetsNames[$i]}/label_ranks.csv Original/UCI/${DatasetsNames[$i]}/${DatasetsNames[$i]}.csv \
	PrefLearnLib/UCI/${DatasetsNames[$i]}/strict_examples.csv PrefLearnLib/UCI/${DatasetsNames[$i]}/eq_examples.csv
done
