using Base.Test



#La función prueba probará si la matriz obtenida a través de la función proyeccion es unitaria
function random_state(dim=2::Int)
    v=randn(1,dim)+randn(1,dim)im
    v=v/norm(v)
    return v'
end

function partial_trace_pure_bipartite_mat(state,dim,system)
    dimtotal=length(state)[1]
    dimcomp=Int(dimtotal/dim)
    if system==1
    psi=reshape(state,(dimcomp,dim))'
        return psi*psi'
        elseif system==2
     psi=reshape(state,(dim,dimcomp))'
        return psi'*psi
    end
end

function prueba(dim::Int)
    state_A=random_state(dim);
    state_B=random_state(dim);
    stateAB=kron(state_A,state_B);
    M=partial_trace_pure_bipartite_mat(stateAB,dim,1)
    if abs(trace(M)-1)>1e-5
        return false
    end
    for k in eigvals(M)
        if k<-1e-5
            return false
        end
    end
    return true
end
    
@test prueba(3)
