package br.com.rangeldev.api_vr_curso.controller.dto;


import br.com.rangeldev.api_vr_curso.domain.entitties.Aluno;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

import java.util.ArrayList;
import java.util.List;

public record AlunoDTO(
        Long codigo,
        @NotBlank(message = "O nome não pode ser vazio")
        @NotNull(message = "O nome não pode ser nulo")
        String nome,
        List<Long> codigosMatricula) {

    public Aluno toEntity() {
        List<Long> lst= new ArrayList<>();
        Aluno aluno = new Aluno();
        aluno.setNome(this.nome);

        if (this.codigo == null) aluno.setCodigo(-1L);

        aluno.setCodigo(codigo);

        if (this.codigosMatricula == null) aluno.setAlunoCodigosMatriculas(lst);
        if (this.codigosMatricula != null) aluno.setAlunoCodigosMatriculas(codigosMatricula);

        return aluno;
    }
}
