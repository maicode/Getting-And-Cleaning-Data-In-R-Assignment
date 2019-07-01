# Getting-And-Cleaning-Data-In-R-Assignment

In this script, we will perform analysis on the following dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

After importing relevant libraries, the script will attempt to read .txt files relevant to the project and store them in appropriately-labeled variables.

Each dataset contains an X, y, and subject training and test dataset. For each, the script will attempt to bind training and test datasets and store them in new variables. 

The y dataset contains numbers representing labels for activities. The script will join a separate dataset called activity_labels to the y dataset by number. The script will then delete the column containing numbers and rename the remaining column "Activity". This leaves a descriptive feature vector.

Once the X datasets have been bound together, the script will take rows from the feature dataset and match descriptive names to the header of the X dataset. Finally, the script selects a subset containing only headers including "mean" or "std" terms and stores this dataset in a new variable.

Now, X, y, and subject datasets are prepared to be bound together by the script. After binding, the script will group by subject and by activity to prepare for the final step. The final step, is an aggregation function, by which each group of subject and activity will have its mean value calculated for all remaining features. 

This last dataset is then exported in a txt file.
