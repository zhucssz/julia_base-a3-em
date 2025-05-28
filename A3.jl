#= PRA INSTALAR O PACKAGE DOS GRÁFICOS

using Pkg
Pkg.add("Plots")

PRA INSTALAR O PACKAGE DOS GRÁFICOS =# 

using Plots

#? leitura da matriz
function ler_matriz(n)
    println("\nDigite a matriz de transição (linha por linha, separados por espaço):")
    P = zeros(n, n)
    for i in 1:n
        print("Linha $i: ")
        linha = parse.(Float64, split(readline()))
        if length(linha) != n
            error("Cada linha deve ter $n valores.")
        end
        if abs(sum(linha) - 1.0) > 1e-5
            error("A soma da linha $i deve ser 1.")
        end
        P[i, :] = linha
    end
    return P
end

#? criar o vetor inicial
function ler_vetor_inicial(n)
    print("\n[+] Digite o vetor de estado inicial (separado por espaço): ")
    v = parse.(Float64, split(readline()))
    if length(v) != n
        error("[!] O vetor deve ter ($n) elementos.")
    end
    if abs(sum(v) - 1.0) > 1e-5
        error("[!] A soma dos elementos deve ser 1.")
    end
    return v
end

#? simulação da cadeia
function simular_markov(P, estado_inicial, passos)
    n = length(estado_inicial)
    historico = zeros(passos + 1, n)
    historico[1, :] = estado_inicial'
    estado = copy(estado_inicial)

    println("\n[#] Estado inicial: ", round.(estado, digits=4))

    for t in 1:passos
        estado = P' * estado
        historico[t+1, :] = estado'
        println("[-] Aós passo ($t): ", round.(estado, digits=4))
    end

    return historico
end

#? func pra salvar o gráfico em um png
function gerar_resultado_grafico(historico)
    passos = size(historico, 1) - 1
    n = size(historico, 2)
    p = plot()
    for i in 1:n
        plot!(0:passos, historico[:, i], label="Estado n°$i", lw=2, marker=:circle)
    end
    xlabel!("Passo")
    ylabel!("Probabilidade")
    title!("Evolução dos estados na cadeia: tema a decidir")

    nome_arq = "grafico_markov.png";

    savefig(nome_arq)
    println("[!] Gráfico salvo como '$nome_arq'")
end

#? inicio do programa chamando as func
println("==[ Simulador cadeias de Markov ]==\n")

print("[i] Quantos estados a cadeia possui? ")
flush(stdout) 
#! tá segurando o buffwr q nem no java essa bosta, tem que enviar o valor 2x no terminal repl
#! dps nois resolve esse b.o.
n = parse(Int, readline())

P = ler_matriz(n)
estado_inicial = ler_vetor_inicial(n)

print("\n[i] Quantos passos deseja simular? ")
flush(stdout)
passos = parse(Int, readline())

historico = simular_markov(P, estado_inicial, passos)

println("\n[!] Gerando gráfico...")
gerar_resultado_grafico(historico)