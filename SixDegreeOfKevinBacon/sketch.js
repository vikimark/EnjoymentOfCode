let graph;
let data;
let dropdown;

function preload(){
	data = loadJSON("bacon.json");
}

function setup() {
	noCanvas();
	graph = new Graph();
	// put setup code here
}

function draw() {
	// put drawing code here
	dropdown = createSelect();
	let n;
	for(let i = 0; i < data.movies.length; i++){
		let movie = data.movies[i];
		nMovie = new Node(movie.title);
		graph.node.push(nMovie);

		for(let j = 0; j < movie.cast.length; j++){
			let actor = movie.cast[j];
			let nActor;
			let duplicate = false;
			for(let k = 0; k < graph.node.length; k++){
				if(actor == graph.node[k].value){
					nActor = graph.node[k];
					duplicate = true;
					console.log("duplicate");
					break;
				}
			}
				if(!duplicate){
				nActor = new Node(actor);
				dropdown.option(actor);
				graph.node.push(nActor);
				}
			nActor.connect(nMovie);
		}

	}

	dropdown.changed(myevent);

	noLoop();
}

function myevent() {
	let goal = graph.bfs(dropdown.value(), "Kevin Bacon");
	graph.printSearch(goal);
}
