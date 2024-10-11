package br.com.rangeldev.api_vr_curso.service.exeception;

import java.io.Serial;

public class NotFoundException extends BusinessException {
    @Serial
    private static final long serialVersionUID = 1L;
    public NotFoundException() {
        super("OPS! Resource not found.");
    }

}
