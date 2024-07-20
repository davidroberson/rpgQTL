setwd("/home/bdc_user")

library(renv)

renv::init()

renv::status()

renv::repair()

library(reticulate)

env::activate()

#export HOME=/home/bdc_user
# Set the HOME directory
Sys.setenv(HOME = "/home/bdc_user")
Sys.setenv(RENV_PATHS_ROOT="/home/bdc_user")

# Specify the path to your project directory
project_path <- getwd()

# venv method ----


library(reticulate)
library(renv)

# Set the HOME directory
Sys.setenv(HOME = "/home/bdc_user")

# Specify the path to your project directory
project_path <- getwd()
print(paste("Project path:", project_path))

# Install Python 3.8
reticulate::install_python(version = '3.8')

# Define the path to the virtual environment within the renv directory
venv_path <- file.path(project_path, "renv", "python")

# Create a virtual environment using Python 3.8
reticulate::virtualenv_create(envname = venv_path, python = reticulate::install_python(version = '3.8'))

# Activate the virtual environment
reticulate::use_virtualenv(venv_path, required = TRUE)

# If requirements.txt exists, install packages
requirements_file <- file.path(project_path, "requirements.txt")
if (file.exists(requirements_file)) {
  reticulate::py_install(requirements = requirements_file, envname = venv_path)
}

# Verify the Python configuration
py_config <- reticulate::py_config()
print(py_config)

reticulate::py_install(packages = c("numpy", "pandas", "tensorqtl"), envname = venv_path)


renv::init()

renv::snapshot()

# Install packages from requirements.txt
requirements_file <- file.path(getwd(), "requirements.txt")
if (file.exists(requirements_file)) {
  reticulate::py_install(requirements = requirements_file, envname = venv_path)
} else {
  # If requirements.txt doesn't exist, you can create it after installing packages
  #reticulate::py_install(c("numpy", "pandas"), envname = venv_path)
  reticulate::py_run_string("import os; os.system('pip freeze > requirements.txt')")
}
