version 1.0

task run_Model {
    input {
        File setup_os_script
        File install_git_script
        File clone_repository_script
        String flepimop_git_repository
        File install_flepimop_script
        File model_configuration_yml
        String model_executable
        File run_model_script
        File move_model_output_script
    }
    command {
        ${setup_os_script}
        ${install_git_script}
        ${clone_repository_script} "${flepimop_git_repository}"
        ${install_flepimop_script}
        ${run_model_script} "${model_executable}" "${model_configuration_yml}"
        ${move_model_output_script}
    }
    runtime {
        docker: "rocker/verse:latest"
    }
    output {
        File response = stdout()
    }
}

workflow flepiMoPWorkflow {
    input {
        File model_configuration_yml
        String model_executable
    }
    call run_Model {
        input:
            setup_os_script = "./scripts/sh/setup_os.sh",
            install_git_script = "./scripts/sh/install_git.sh",
            clone_repository_script = "./scripts/sh/clone_git_repository.sh",
            flepimop_git_repository = "https://github.com/HopkinsIDD/flepiMoP.git",
            install_flepimop_script = "./scripts/sh/flepimop/install_flepimop.sh",
            model_configuration_yml = model_configuration_yml,
            model_executable = model_executable,
            run_model_script = "./scripts/sh/flepimop/run_gempyor.sh",
            move_model_output_script = "./scripts/sh/move_model_output.sh"
    }
}

