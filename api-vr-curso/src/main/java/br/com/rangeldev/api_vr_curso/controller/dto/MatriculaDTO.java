package br.com.rangeldev.api_vr_curso.controller.dto;

import br.com.rangeldev.api_vr_curso.domain.entitties.Aluno;
import br.com.rangeldev.api_vr_curso.domain.entitties.Curso;
import br.com.rangeldev.api_vr_curso.domain.entitties.Matricula;
import jakarta.validation.constraints.NotBlank;

public record MatriculaDTO(
        Long codigo,
        Curso curso,
        @NotBlank(message = "Aluno não pode ser vazio ou nulo") Aluno aluno) {

    public Matricula toEntity() {

        Matricula matricula = new Matricula();

        if (this.codigo == null)
            matricula.setCodigo(-1L);

        matricula.setCodigo(codigo);

        if (this.aluno != null)
            matricula.setAluno(aluno);
        

        matricula.setCurso(curso);

        return matricula;
    }
}
