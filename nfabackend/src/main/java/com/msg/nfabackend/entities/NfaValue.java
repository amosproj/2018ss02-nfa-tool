package com.msg.nfabackend.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="nfa_verbindlichkeit")
public class NfaValue {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="ID")
	private long id;
	
	@Column (name ="nfa_verbindlichkeit_from")
	private long nfaVerbindlichkeitFrom;
	
	@Column (name ="nfa_Verbindlichkeit_till")
	private long nfaVerbindlichkeitTill;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getNfaVerbindlichkeitFrom() {
		return nfaVerbindlichkeitFrom;
	}

	public void setNfaVerbindlichkeitFrom(long nfaVerbindlichkeitFrom) {
		this.nfaVerbindlichkeitFrom = nfaVerbindlichkeitFrom;
	}

	public long getNfaVerbindlichkeitTill() {
		return nfaVerbindlichkeitTill;
	}

	public void setNfaVerbindlichkeitTill(long nfaVerbindlichkeitTill) {
		this.nfaVerbindlichkeitTill = nfaVerbindlichkeitTill;
	}

	
}