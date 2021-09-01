class Graph{
	
	constructor(){
		this.node = [];
		this.queue = [];
	}

	bfs(sName, gName){

		this.reset();

		let start, goal;
		for(let i = 0; i < this.node.length; i++){
			if(sName == this.node[i].value){
				start = this.node[i];
			}
			if(gName == this.node[i].value){
				goal = this.node[i];
			}
		}
		this.queue.push(start);

		while(this.queue.length > 0){
			let now = this.queue.shift();
			now.search = true;

			if(now.value === goal.value){
				return now;
				break;
			}else {
				for(let i = 0; i < now.edges.length; i++){
					let neighbor = now.edges[i];
					if(!neighbor.search){
						neighbor.parent = now;
						this.queue.push(neighbor);
					}
				}
			}
		}
	}

	reset(){
		for(let i = 0; i < this.node.length; i++){
			let n = this.node[i];
			n.search = false;
			n.parent = null;
		}
		// empty array option 1 : this will give new reference to queue (this way could be dangerous) also this is fastest way
		// this.queue = [];

		// option 2 : set array length to 0 (safer way but slower)
		this.queue.length = 0;
	}

	printSearch(goal){
		let next = goal;
		let temp = [];
		let txt = "";
		while(next.parent != null){
			temp.push(next.value);
			next = next.parent;
		}
		temp.push(next.value);

		for(let i = temp.length - 1; i >= 0; i--){
			txt += temp[i];
			if(i != 0){
				txt += " -> ";
			}
		}
		createP(txt);
	}

}