class Node{
	constructor(val){
		this.value = val;
		this.edges = [];
		this.search = false;
		this.parent = null;
	}

	connect(n){
		this.edges.push(n);
		n.edges.push(this);
	}
}