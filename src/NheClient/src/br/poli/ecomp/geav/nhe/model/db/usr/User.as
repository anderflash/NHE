package br.poli.ecomp.geav.nhe.model.db.usr
	
	public class User implements IUser{
		{
			if(getQualifiedClassName(elemento) == getQualifiedClassName(this))
			{
				if(IMZTable(elemento).identificador == identificador)
					return true;
				else
					return false;
			}
			else
			{
				return false;
			}
		}
		public function matchesAll(elemento:IMZTable, operacao:Boolean, operadores:Object):Boolean
		{
			return MZOperators.matchesAll(this,elemento,operacao,operadores);
		}