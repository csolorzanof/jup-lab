#Initial folder setup
Before running docker compose up create the folder structure to hold and persist the data
of jupyterlab between container recreations and executions. 

In a terminal at the root folder where the Dockerfile and docker-compose.yml file exist run the following commands:

```bash
mkdir cache
mkdir workspace

mkdir workspace/notebooks
mkdir workspace/datasets
mkdir workspace/models
mkdir workspace/exports
mkdir workspace/projects
mkdir workspace/scratch
```