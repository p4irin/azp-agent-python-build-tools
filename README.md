# Install Python build tools on an Azure Pipelines self-hosted agent

To build and test an application on different versions of Python you need to install them when using a self-hosted agent with Azure Pipelines. Most of everything else you need can be installed with pip.
When installed on a self-hosted agent you can use the UsePythonVersion@0 in your Azure pipeline as you would with a Microsoft hosted agent. Installation is required as UsePythonVersion@0 doesn't support automatic downloading of missing Python versions on self-hosted agents.

## Stack

This is what I used. So, you might need to adapt.

* Raspberry Pi 4, 8Gb
* Ubuntu server 22.04.3 LTS jammy (arm64).
  Comes with Python 3.10.12 pre-installed
* Also tested script on ubuntu:jammy Docker image (amd64)

## build-tools.sh

This script will install Python versions in the agent's tool cache according to the requirements explained [here](https://learn.microsoft.com/en-us/azure/devops/pipelines/tasks/reference/use-python-version-v0?view=azure-pipelines&viewFallbackFrom=azure-devops#how-can-i-configure-a-self-hosted-agent-to-use-this-task:~:text=How%20can%20I%20configure%20a%20self%2Dhosted%20agent%20to%20use%20this%20task%3F). By default this cache is located at _work/_tool in the directory where the agent is installed. The Python versions installed are from the deadsnakes apt repository. After installing from the deadsnakes repository the script installs each Python version using the venv package in the tool cache. The versions installed are 3.8, 3.9, 3.10 and 3.11

### Usage

1. SSH into your agent's host
1. cd into it's tool cache. 
1. Execute the following commands
   ```bash
   $ sudo apt-get update
   $ curl https://raw.githubusercontent.com/p4irin/azp-agent-python-build-tools/main/build-tools.sh > build-tools.sh
   $ chmod u+x build-tools.sh
   $ ./build-tools.sh
   ```
1. Restart your agent. You should be able to run jobs in a matrix using different Python versions.
