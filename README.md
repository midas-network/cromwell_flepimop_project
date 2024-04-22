# cromwell_flepimop_project

This project demostrates running FlepiMoP using Cromwell, Python, R, and Docker.

## Pre-requisites:
 
 1. JAVA must be installed and be a minimum version of 11.
 2. Docker must also be installed.

Please note: The cromwell workflow script will check for these requirements and stop execution if they are not met.

## Create your model

 1. Create your model configuration file according to FlepiMoP specifications and save in this folder.
 2. Please specify in your model for input files to be in the model_inputs folder.
 3. Place all of your input files in the model_inputs folder.

## To execute:
 
 1. Edit model_specs.json using a text editor to specify the model configuration file
 	as well as the executable, then save.
~~~
{
	"flepiMoPWorkflow.model_configuration_yml": "config_sample_2pop.yml",
	"flepiMoPWorkflow.model_executable": "gempyor-simulate"
}
~~~
 2. From the command line execute the Cromwell workflow.
~~~
./cromwell_workflow.sh
~~~


## Results:

Results will be inside the model_output folder.


