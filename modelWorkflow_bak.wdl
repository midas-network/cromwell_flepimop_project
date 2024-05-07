version 1.0

task run_Model {
    input {
        File setup_os_script
        File install_git_script
        File clone_repository_script
        File move_model_output_script
        String model_git_repository
        File install_model_script
        File model_configuration_yml
        String model_executable
        File run_model_script
        String model_output_folder
        String model_runtime_docker
    }

    String model_output_files = "model_output_files.txt"

    command {
        ${setup_os_script}
        ${install_git_script}
        ${clone_repository_script} "${model_git_repository}"
        ${install_model_script}
        ${run_model_script} "${model_executable}" "${model_configuration_yml}"
        find ./"${model_output_folder}" -name '*.parquet' > "${model_output_files}"
    }

    runtime {
        docker: "${model_runtime_docker}"
    }

    output {
        Array[File] output_files = read_lines(model_output_files)
    }
}

task moveResults {
    input {
        File move_results_script
        File output_file
        String runtime_docker
    }

    command {
        ${move_results_script} "${output_file}"
    }

    runtime {
        docker: "${runtime_docker}"
    }

    output {
        String out = read_string(stdout())
    }
}

workflow modelWorkflow {
    input {
        File setup_os_script
        File install_git_script
        File clone_repository_script
        File move_model_output_script
    }

    call run_Model {
        input:
            setup_os_script = setup_os_script,
            install_git_script = install_git_script,
            clone_repository_script = clone_repository_script,
            move_model_output_script = move_model_output_script
    }

    Array[File] model_output_files = run_Model.output_files

    scatter (outputFile in model_output_files) {
        call moveResults {
            input:
                move_results_script = "./scripts/sh/move_results.sh",
                output_file = outputFile
        }
    }

    output {
        Array[File] outputFiles = model_output_files
    }
}
