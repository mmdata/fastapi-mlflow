## Intro
In this folder with test the use of MlFlow to monitor machine learning models. We will use an example dataset https://scikit-learn.org/0.19/datasets/twenty_newsgroups.html to build a model to classify text in different categories. We will build a pipeline using `TfIDF` and a simple bayes classifier and we will log the parameters, accuracy and confusion matrix.

## Setup 
If you are using Linux/Mac you can set up the environment by using the `cli.sh`. Run:

- `./cli.sh`
- `ìnstall` 
- `run_jupyter` 

Check that the jupyter notebook is using kernel `env`

## Run
To run you can simply select `Kernel-> Restart& Run All`. To visualize the results:
- `mlflow ui --backend-store-uri sqlite:///mlflow_database.db`
and then go to `http://127.0.0.1:5000/`
