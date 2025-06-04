#= PRA INSTALAR O PACKAGE DOS GRÁFICOS

using Pkg
Pkg.add("Plots")

PRA INSTALAR O PACKAGE DOS GRÁFICOS =# 
using Plots

#? leitura da matriz
function ler_matriz(n)
    println("\n[i] Digite a matriz de transição (linha por linha, separados por espaço):")
    P = zeros(n, n)
    for i in 1:n
        while true
            print("Linha $i: ")
            entrada = readline()
            partes = split(entrada)
            try
                linha = parse.(Float64, partes)
                if length(linha) != n
                    println("[!] Cada linha deve ter exatamente $n valores.")
                    continue
                end
                if abs(sum(linha) - 1.0) > 1e-5
                    println("[!] A soma dos valores da linha $i deve ser 1. Foi: $(sum(linha))")
                    continue
                end
                P[i, :] = linha
                break
            catch
                println("[!] Entrada inválida. Use apenas números, separados por espaço.")
            end
        end
    end
    return P
end

#? criar o vetor inicial
function ler_vetor_inicial(n)
    while true # falta fechar aq
        print("\n[i] Digite o vetor de estado inicial (separado por espaço): ")
        entrada = readline()
        partes = split(entrada)
        try
            v = parse.(Float64, partes)
            if length(v) != n
                println("[!] O vetor deve ter $n elementos.")
                continue
            end
            if abs(sum(v) - 1.0) > 1e-5
                println("[!] A soma dos elementos deve ser 1. Foi: $(sum(v))")
                continue
            end
            return v
        catch
            println("[!] Entrada inválida. Use apenas números, separados por espaço.")
        end
    end
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
        println("[-] Após passo ($t): ", round.(estado, digits=4))
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
    title!("EVOLUÇÃO DOS ESTADOS DA CADEIA:")

    nome_arq = "grafico_markov.png";

    savefig(nome_arq)
    println("\n[+] Gráfico salvo como '$nome_arq'")
end

#? inicio do programa chamando as func
println("==[ Simulador cadeias de Markov ]==\n")

print("[i] Quantidade de estados da cadeia: ")
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

println("\n[#] Gerando gráfico...")
gerar_resultado_grafico(historico)

# pergunta qnt de estados, valor inicial, qnt de passos, cada linha da matriz