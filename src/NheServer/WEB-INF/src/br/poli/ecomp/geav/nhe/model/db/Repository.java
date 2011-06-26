package br.poli.ecomp.geav.nhe.model.db;

import java.lang.reflect.InvocationTargetException;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Vector;

public class Repository
{

	public Class<? extends Table> classe;
	private Vector<ITable> vetor;
	
	/**
	 * Construtor do Repositório, deve passar a classe baseada em 
	 * IMZTabela no parâmetro 
	 * @param classe Classe que estende {@link ITable}
	 * 
	 */
	public Repository(Class<? extends Table> classe)
	{
		this.classe = classe;
		this.vetor = new Vector<ITable>();
	}
	
	/**
	 * Adicionar Elemento. Pode lançar um erro RepositorioError do tipo
	 * ELEMENTO_JA_CADASTRADO se encontrar um elemento no vetor, ou do tipo
	 * ELEMENTO_CLASSE_ERRADA se for de um tipo IMZTabela diferente
	 * 
	 * @param elemento Elemento do tipo IMZTabela (deve ser igual à classe passada
	 * no construtor.
	 * 
	 */
	public void adicionar(ITable elemento) throws RepositoryException
	{
		if(classe.isInstance(elemento))
		{
			if(elemento.get_identificador() == 0)
				vetor.add(elemento);
			else
			{
				for(int i = 0; i < vetor.size(); i++)
				{
					if(vetor.get(i).matches(elemento))
					{
						throw new RepositoryException(RepositoryException.ELEMENTO_JA_CADASTRADO);
					}
				}
				vetor.add(elemento);
			}
		}
		else
		{
			throw new RepositoryException(RepositoryException.ELEMENTO_CLASSE_ERRADA);
		}
	}
	
	public ITable adicionarComCuidado(ITable elemento) throws RepositoryException, IllegalArgumentException, IllegalAccessException, InvocationTargetException
	{
		return adicionarComCuidado(elemento, true, null);
	}
	public ITable adicionarComCuidado(ITable elemento, Boolean operacao, HashMap<String, Integer> operadores) throws RepositoryException, IllegalArgumentException, IllegalAccessException, InvocationTargetException
	{
		
		ITable eleTmp = procurar(elemento, operacao, operadores);
		if(eleTmp != null) return eleTmp;
		else adicionar(elemento);
		return elemento;
	}
	
	/**
	 * Remover Elemento. Pode lançar um erro RepositorioError do tipo
	 * ELEMENTO_NAO_CADASTRADO se não encontrar um elemento no vetor, ou do tipo
	 * ELEMENTO_CLASSE_ERRADA se for de um tipo IMZTabela diferente
	 * 
	 * @param elemento Elemento do tipo IMZTabela (deve ser igual à classe passada
	 * no construtor.
	 * 
	 */
	public void remover(ITable elemento) throws RepositoryException
	{
		if(classe.isInstance(elemento))
		{
			for(int i = 0; i < vetor.size(); i++)
			{
				if(vetor.get(i).matches(elemento))
				{
					vetor.remove(i);
					return;
				}
			}
			throw new RepositoryException(RepositoryException.ELEMENTO_NAO_CADASTRADO);
		}
		else
		{
			throw new RepositoryException(RepositoryException.ELEMENTO_CLASSE_ERRADA);
		}
	}
	/**
	 * Ordena a lista usando uma função de comparação.
	 * A função deve retornar -1, 0 e 1, de acordo com alguma comparação.<br/>
	 * Se o valor é -1, um valor estará antes do outro
	 * Se o valor é  0, um valor estará logo atrás do outro
	 * Se o valor é  1, um valor estará depois do outro
	 * @param funcao Função de comparação com os parâmetros
	 * 
	 */
	public void ordenarLista(Comparator<ITable> comparador)
	{
		Collections.sort(vetor, comparador);
	}
	
	/**
	 * Clona o repositório, não clona os objetos
	 * Fazer no futuro o clone dos objetos com uma interface IClonable
	 * @return Um novo repositório com os mesmos objetos (inclusive as referências)
	 * 
	 */
	public Repository clone()
	{
		Repository repositorio = new Repository(classe);
		for(int i = 0; i < vetor.size(); i++)
		{
			try {
				repositorio.adicionar(vetor.get(i));
			} catch (RepositoryException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return repositorio;
	}
	
	/**
	 * Mesma lógica do <code>procurarLista</code>, porém retornando apenas um elemento 
	 * @param elemento
	 * @param operacao
	 * @param operadores
	 * @return elemento encontrado ou <code>null</code> 
	 * @throws RepositoryException 
	 * @throws InvocationTargetException 
	 * @throws IllegalAccessException 
	 * @throws IllegalArgumentException 
	 * 
	 */
	public ITable procurar(ITable elemento) throws RepositoryException, IllegalArgumentException, IllegalAccessException, InvocationTargetException
	{
		return procurar(elemento, true, null);
	}
	public ITable procurar(ITable elemento, Boolean operacao, HashMap<String, Integer> operadores) throws RepositoryException, IllegalArgumentException, IllegalAccessException, InvocationTargetException
	{
		if(classe.isInstance(elemento))
		{
			for(int i = 0 ; i < vetor.size(); i++)
			{
				if(operadores != null)
				{
					if(vetor.get(i).matchesAll(elemento,operacao, operadores))
						return vetor.get(i);
				}
				else if(vetor.get(i).matches(elemento))
					return vetor.get(i);
			}
			return null;
		}
		else
		{
			throw new RepositoryException(RepositoryException.ELEMENTO_CLASSE_ERRADA);
		}
	}
	
	/**
	 * Procurar uma lista dando seus operadores (Maior, menor...) e se usa lógica And ou Or 
	 * @param elemento
	 * @param operacao
	 * @param operadores
	 * @return 
	 * @throws InvocationTargetException 
	 * @throws IllegalAccessException 
	 * @throws IllegalArgumentException 
	 * 
	 */
	public Vector<ITable> procurarLista(ITable elemento, Boolean operacao, HashMap<String, Integer> operadores) throws RepositoryException, IllegalArgumentException, IllegalAccessException, InvocationTargetException
	{
		if(classe.isInstance(elemento))
		{
			Vector<ITable> vetorTmp = new Vector<ITable>();
			for(int i = 0; i < vetor.size(); i++)
			{
				if(vetor.get(i).matchesAll(elemento,operacao, operadores))
				{
					vetorTmp.add(vetor.get(i));
				}
			}
			return vetorTmp;
		}
		else
		{
			throw new RepositoryException(RepositoryException.ELEMENTO_CLASSE_ERRADA);
		}
	}
	
	/**
	 * Verificar se o repositório está vazio, para evitar procurar elementos.
	 * 
	 * @return <code>true</code> se o repositório estiver vazio e <code>false</code>
	 * se não estiver  
	 * 
	 */
	public Boolean ehVazio()
	{
		return vetor.size() == 0;
	}
	/**
	 * Atualizar Elemento. Pode lançar um erro RepositorioError do tipo
	 * ELEMENTO_NAO_CADASTRADO se não encontrar um elemento no vetor, ou do tipo
	 * ELEMENTO_CLASSE_ERRADA se for de um tipo IMZTabela diferente
	 * 
	 * @param elemento Elemento do tipo IMZTabela (deve ser igual à classe passada
	 * no construtor.
	 * 
	 */
	public void atualizar(ITable elemento) throws RepositoryException
	{
		if(classe.isInstance(elemento))
		{
			for(int i = 0; i < vetor.size(); i++)
			{
				if(vetor.get(i).matches(elemento))
				{
					vetor.setElementAt(elemento, i);
					return;
				}
			}
			throw new RepositoryException(RepositoryException.ELEMENTO_NAO_CADASTRADO);
		}
		else
		{
			throw new RepositoryException(RepositoryException.ELEMENTO_CLASSE_ERRADA);
		}
	}
	
	
	/**
	 * Verificar se o elemento existe no repositório 
	 * @param elemento
	 * @param operacao
	 * @param operadores
	 * @return true se existe ou false se não existe 
	 * @throws InvocationTargetException 
	 * @throws IllegalAccessException 
	 * @throws IllegalArgumentException 
	 * 
	 */
	public Boolean existe(ITable elemento, Boolean operacao, HashMap<String, Integer> operadores) throws RepositoryException, IllegalArgumentException, IllegalAccessException, InvocationTargetException
	{
		if(this.classe.isInstance(elemento))
		{
			for(int i = 0; i < vetor.size(); i++)
			{
				if(vetor.get(i).matchesAll(elemento,operacao, operadores))
				{
					return true;
				}
			}
			return false;
		}
		else
		{
			throw new RepositoryException(RepositoryException.ELEMENTO_CLASSE_ERRADA);
		}
	}
	
	
	/**
	 * Retornar o vetor de IMZTabela 
	 * @return vetor do tipo Vector.<IMZTabela> 
	 * 
	 */
	public Vector<ITable> get_vetor()
	{
		return vetor;
	}
	/**
	 * @private
	 */
	public void set_vetor(Vector<ITable> value)
	{
		vetor = value;
	}
	/**
	 * Retornar a classe do repositório. Se for feito um new Repositorio(Abacaxi),
	 * então esta função retorna Abacaxi
	 * @return classe do repositorio do tipo Class
	 * 
	 */
	public Class<? extends Table> get_classe()
	{
		return classe;
	}

	/**
	 * @private
	 */
	public void set_classe(Class<? extends Table> value)
	{
		classe = value;
	}
}
