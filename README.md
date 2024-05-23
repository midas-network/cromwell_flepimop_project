# cromwell_flepimop_project

This project demostrates running FlepiMoP using Cromwell, Python, R, and Docker.

## Pre-requisites:
 
 1. JAVA must be installed and be a minimum version of 11.
 2. Docker must also be installed.

Please note: The cromwell workflow script will check for these requirements and stop execution if they are not met.

## Create your model

 1. Create your model configuration file according to FlepiMoP specifications and save it in this folder.
 2. Please specify in the json where the input files for your model are located.  The default setting is 'model_input'.
 3. Place all of your input files in this folder.

## To execute:
 
 1. Edit <b>modelWorkflow_inputs.json</b> using a text editor to specify the model configuration file
 	as well as the executable, then save.

 #### Non-Inference run example:
~~~
{
  "modelWorkflow.run_Model.name_of_this_model_run": "flepimop",
  "modelWorkflow.run_Model.model_configuration_yml": "config_sample_2pop.yml",
  "modelWorkflow.run_Model.model_executable": "gempyor-simulate",
  "modelWorkflow.run_Model.model_input_folder": "model_input",

  "modelWorkflow.run_Model.model_git_repository": "https://github.com/HopkinsIDD/flepiMoP.git",
  "modelWorkflow.run_Model.model_output_folder": "model_output",
  "modelWorkflow.run_Model.model_output_file_types": "[parquet]",
  "modelWorkflow.run_Model.install_model_script": "./scripts/sh/flepimop/install_model.sh",
  "modelWorkflow.run_Model.run_model_script": "./scripts/sh/flepimop/run_model.sh",
  "modelWorkflow.run_Model.model_runtime_docker": "rocker/verse:latest",
  "modelWorkflow.setup_os_script": "./scripts/sh/setup_os.sh",
  "modelWorkflow.clone_repository_script": "./scripts/sh/clone_git_repository.sh",
  "modelWorkflow.copy_cromwell_logs_script": "./scripts/sh/copy_cromwell_logs.sh",
  "modelWorkflow.copy_model_output_script": "scripts/python/copy_model_output.py"
}
~~~

 #### Inference run example:
~~~
{
  "modelWorkflow.run_Model.name_of_this_model_run": "flepimop",
  "modelWorkflow.run_Model.model_configuration_yml": "config_sample_2pop_inference.yml",
  "modelWorkflow.run_Model.model_executable": "Rscript  flepiMoP/flepimop/main_scripts/inference_main.R",
  "modelWorkflow.run_Model.model_input_folder": "model_input",

  "modelWorkflow.run_Model.model_git_repository": "https://github.com/HopkinsIDD/flepiMoP.git",
  "modelWorkflow.run_Model.model_output_folder": "model_output",
  "modelWorkflow.run_Model.model_output_file_types": "[parquet]",
  "modelWorkflow.run_Model.install_model_script": "./scripts/sh/flepimop/install_model.sh",
  "modelWorkflow.run_Model.run_model_script": "./scripts/sh/flepimop/run_model.sh",
  "modelWorkflow.run_Model.model_runtime_docker": "rocker/verse:latest",
  "modelWorkflow.setup_os_script": "./scripts/sh/setup_os.sh",
  "modelWorkflow.clone_repository_script": "./scripts/sh/clone_git_repository.sh",
  "modelWorkflow.copy_cromwell_logs_script": "./scripts/sh/copy_cromwell_logs.sh",
  "modelWorkflow.copy_model_output_script": "scripts/python/copy_model_output.py"
}
~~~
 2. From the command line execute the Cromwell workflow.
~~~
./cromwell_workflow.sh
~~~


## Results:

If the workflow <b>Succeeded</b>b>, results will be inside the model_output folder.

If the workflow <b>Failed</b>, see <b>stderr</b> file in the model_output folder.

For additional information, see <b>stdout</b> file in the model_output folder.

