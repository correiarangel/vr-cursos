package br.com.rangeldev.api_vr_curso.controller.dto;


import br.com.rangeldev.api_vr_curso.domain.entitties.Curso;

import jakarta.validation.constraints.NotBlank;

import java.util.ArrayList;
import java.util.List;

public record CursoDTO(
        Long codigo,
        @NotBlank(message = "O descrição não pode ser vazio")
        String descricao,
        @NotBlank(message = "O ementa não pode ser vazio")
        String ementa,
        List<Long> codigosMatricula) {

    public Curso toEntity() {
        List<Long> lst = new ArrayList<>();
        Curso curso = new Curso();

        if (this.codigo == null) curso.setCodigo(-1L);

        curso.setCodigo(codigo);
        curso.setDescricao(this.descricao);
        curso.setEmenta(this.ementa);
        if (this.codigosMatricula == null) curso.setCursoCodigosMatriculas(lst);
        if (this.codigosMatricula != null) curso.setCursoCodigosMatriculas(codigosMatricula);

        return curso;
    }
}
