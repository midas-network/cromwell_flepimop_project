version 1.0

task run_Model {
    input {
        File setup_os_script
        File install_git_script
        File clone_repository_script
        File copy_cromwell_logs_script
        File copy_model_output_script
        String model_git_repository
        File install_model_script
        File model_configuration_yml
        String model_executable
        File run_model_script
        String model_output_folder
        String model_output_file_types
        String model_runtime_docker
    }

    String model_output_files = "model_output_files.txt"

    command {
        ${setup_os_script}
        ${install_git_script}
        ${clone_repository_script} "${model_git_repository}"
        ${install_model_script}
        ${run_model_script} "${model_executable}" "${model_configuration_yml}"
        find ./"${model_output_folder}" -name '*.${model_output_file_types}' > "${model_output_files}"
        python3 ${copy_model_output_script} "${model_output_files}"
        ${copy_cromwell_logs_script} "${model_output_folder}"
    }

    runtime {
        docker: "${model_runtime_docker}"
    }

    output {
        Array[File] output_files = read_lines(model_output_files)
    }
}

workflow modelWorkflow {
    input {
        File setup_os_script
        File install_git_script
        File clone_repository_script
        File copy_cromwell_logs_script
        File copy_model_output_script
    }

    call run_Model {
        input:
            setup_os_script = setup_os_script,
            install_git_script = install_git_script,
            clone_repository_script = clone_repository_script,
            copy_cromwell_logs_script = copy_cromwell_logs_script,
            copy_model_output_script = copy_model_output_script
    }
}
