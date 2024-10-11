package br.com.rangeldev.api_vr_curso.domain.entitties;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;


@Entity
@Table(name = "TB_CURSO")

public class Curso implements Serializable {

    private static Long SERIAL_CURSO_ID =1L;

    public Curso() {
    }

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "codigo", nullable = false, unique = true)
    private Long codigo;

    @Column(name = "descricao", nullable = false, length = 50)
    @NotNull(message = "Descrição é obrigatório.")
    private String descricao;

    @Column(name = "ementa", nullable = false)
    @NotNull(message = "Ementa é obrigatório.")
    private String ementa;

    @ElementCollection
    //@CollectionTable(name = "TB_CURSO_ALUNO", joinColumns = @JoinColumn(name = "codigo"))
    @Column(name = "codigo_matricula")
    private List<Long> cursoCodigosMatriculas=new ArrayList<>();


    public List<Long> getCursoCodigosMatriculas() {
        return cursoCodigosMatriculas;
    }

    public void setCursoCodigosMatriculas(List<Long> codigosMatricula) {
        this.cursoCodigosMatriculas = codigosMatricula;
    }

    public Long getCodigo() {
        return codigo;
    }

    public void setCodigo(Long codigo) {
        this.codigo = codigo;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public void setEmenta(String ementa) {
        this.ementa = ementa;
    }

    public String getEmenta() {
        return this.ementa;
    }

}
