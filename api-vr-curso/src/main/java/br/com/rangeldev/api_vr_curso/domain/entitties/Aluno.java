package br.com.rangeldev.api_vr_curso.domain.entitties;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "TB_ALUNO")
public class Aluno implements Serializable {
    private static Long SERIAL_ALUNO_ID =1L;

    public Aluno() {
    }

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "codigo", nullable = false, unique = true)
    private Long codigo;


    @Column(name = "nome", nullable = false, length = 50)
    @NotNull(message = "O nome do aluno é obrigatório.")
    private String nome;

    @ElementCollection
    //@CollectionTable(name = "TB_CURSO_ALUNO", joinColumns = @JoinColumn(name = "codigo"))
    @Column(name = "codigo_matricula")
    private List<Long> alunoCodigosMatriculas=new ArrayList<>();;

    public List<Long> getAlunoCodigosMatriculas() {
        return alunoCodigosMatriculas;
    }

    public void setAlunoCodigosMatriculas(List<Long> codigosMatricula) {
        this.alunoCodigosMatriculas = codigosMatricula;
    }

    public void setCodigo(Long codigo) {
        this.codigo = codigo;
    }

    public Long getCodigo() {
        return codigo;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }


}