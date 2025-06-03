using Plots
using Printf

function simular_carreira()
    estados = ["Estudante", "Júnior", "Pleno", "Sênior", "Aposentado", "Desempregado"]

    print("[i] Passos: ")
    passos = readline()

    println("[ MATRIZ DE TRANSIÇÃO (input) // CADA VALOR SEPARADO POR ESPAÇO ]")
    P = zeros(6, 6)
    for i in 1:6
        while true
            print("[i] Linha $i: ")
            entrada = readline()
            partes = split(entrada)

            if length(partes) != 6
                println("[!] Cada linha deve ter exatamente 6 valores separados por espaço.")
                continue
            end

            linha = parse.(Float64, partes)
            soma = sum(linha)

            if abs(soma - 1.0) > 1e-6 #! tem que ser assim pq tá dando erro o (abs)olute, fica aproximando de 0.9999999
                println("[!] A soma da linha é $soma. O valor deve ser = a 1.")
                continue
            end

            P[i, :] = linha
            break
        end
    end

    #* VALORES
    v = [1.0, 0, 0, 0, 0, 0] #! vetor inicial fixo, todos começam como estudante
    #passos = 20 #! qnt de passos da cadeia
    nome_arq = "grafico_carreira2.png" #! nome do arquivo .png de gráfico

    historico = zeros(passos + 1, length(v))
    historico[1, :] = v

    println("\n[#] Passo 0: ", round.(v, digits=4))
    for i in 1:passos
        v = P' * v
        historico[i+1, :] = v
        println("[#] Passo $i: ", round.(v, digits=4))
    end

    # valores finais em porcentagem
    final = historico[end, :] .* 100
    @printf("\n[ VALORES FINAIS EM PORCENTAGEM ]\n
    [ Estudante = %.2f%% ]\n
    [ Júnior = %.2f%% ]\n
    [ Pleno = %.2f%% ]\n
    [ Sênior = %.2f%% ]\n
    [ Aposentado = %.2f%% ]\n
    [ Desempregado = %.2f%% ]\n", 
    final[1],
    final[2],
    final[3],
    final[4],
    final[5],
    final[6])

    # gráfico
    plot()
    for i in 1:length(v)
        plot!(0:passos, historico[:, i], label=estados[i], lw=2, marker=:circle)
    end

    xlabel!("PASSO")
    ylabel!("PROBABILIDADE (%)")
    title!("Evolução profissional de uma pessoa")
    savefig(nome_arq)
    println("\n[+] Gráfico salvo como '$nome_arq'")
end

simular_carreira()
