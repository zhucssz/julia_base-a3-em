using Plots

function simular_carreira()
    estados = ["Estudante", "Júnior", "Pleno", "Sênior", "Gerente", "Aposentado", "Desempregado"]

    # matriz d transição
    P = [
        0.2  0.7    0.0    0.0    0.0     0.0     0.1;
        0.0  0.4    0.5    0.0    0.0     0.0     0.1;
        0.0  0.0    0.5    0.4    0.0     0.0     0.1;
        0.0  0.0    0.0    0.6    0.3     0.0     0.1;
        0.0  0.0    0.0    0.0    0.7     0.2     0.1;
        0.0  0.0    0.0    0.0    0.0     1.0     0.0;
        0.0  0.0    0.0    0.0    0.0     0.0     1.0
    ]

    v = [1.0, 0, 0, 0, 0, 0, 0]  # a pessoa começa como estudante
    passos = 10 # vai ser 10 passos por enqnt
    historico = zeros(passos + 1, length(v))
    historico[1, :] = v

    for i in 1:passos
        v = P' * v
        historico[i+1, :] = v
        println("[#] Passo $i: ", round.(v, digits=4))
    end

    # valores finais em porcentagem
    final = historico[end, :] .* 100
    @printf("\n[ VALORES FINAIS EM PORCENTAGEM ]\n[ Estudante = %.2f%% ]\n[ Júnior = %.2f%% ]\n[ Pleno = %.2f%% ]\n[ Sênior = %.2f%% ]\n[ Gerente = %.2f%% ]\n[ Aposentado = %.2f%% ]\n[ Desempregado = %.2f%% ]\n", final[1], final[2], final[3], final[4], final[5], final[6], final[7])

    # criação do gráfico
    plot()
    for i in 1:length(v)
        plot!(0:passos, historico[:, i], label=estados[i], lw=2, marker=:circle)
    end

    xlabel!("PASSO")
    ylabel!("PROBABILIDADE (%)")

    nome_arq = "grafico_carreira.png"

    title!("Evolução profissional de uma pessoa")
    savefig(nome_arq)

    println("\n[+] Gráfico salvo como '$nome_arq'")
end

simular_carreira()

