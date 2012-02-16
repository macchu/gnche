
var recipeTitle="unknown";
var recipePicture="";
var recipeURL="";
var recipeMainURL="";


 $(document).ready(function() {
   $('.add_recipe').hide();
 });

function showAddRecipeDiv(){
	console.log("showAddRecipeDiv()...");
	recipeURL = document.getElementById('newRecipeURL').value;
	console.log("New recipe URL");
	getAll();

}	

function getAll(){
	getTitle();
	console.log("getAll()..." + recipeTitle);
}

function getTitle(){
	//recipeURL = document.getElementById('url').value;
	console.log("getTitle()...recipeURL = " + recipeURL);
	var yql_url = "http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20html%20where%20url%3D%22" + encodeURIComponent(recipeURL) + "%22%20and%0A%20%20%20%20%20%20xpath%3D'%2F%2Ftitle'&format=json&callback=?";

	$.getJSON(yql_url, getTitleCallback);
}

function getTitleCallback(json)
{
	console.log("getTitleCallback...");
	  if (json && json.query && json.query.results && json.query.results.title) {
		console.log("Returning title...");
		recipeTitle = json.query.results.title;
	  }
	  else{
		console.log("Title not found.");
		recipeTitle = "Please enter title";
	  }
	  getPictures();
}

function getPictures(){
	console.log("getPictures()...");
	var url = document.getElementById('recipe_url').value;
	var yql_url = "http://query.yahooapis.com/v1/public/yql?q=select%20src%20from%20html%20where%20url%3D%22" + encodeURIComponent(recipeURL) + "%22%20and%0A%20%20%20%20%20%20xpath%3D'%2F%2Fa%20%7C%20%2F%2Fimg'&format=json&callback=?";
	$.getJSON(yql_url, getPicturesCallback);
}

function getPicturesCallback(json){
	console.log("getPicturesCallback()...");
	 if (json && json.query && json.query.results) {
		console.log("Returning headers...");
		console.log("..." + json.query.results.img[2].src);
		findBestPicture(json.query.results.img);
	  }
	  else{
		console.log("Headers not found.");
		
	  }
	  assembleScrapedItems();
	
}

function findBestPicture(image){
	console.log("Finding best picture for: " + recipeTitle);
	
	//Remove non-letters and numbers from the title.
	var regexNonAlpha = /[\W|_]/g;
	var cleanTitle = recipeTitle.replace(regexNonAlpha, " ").toLowerCase();
	
	//Hacks for epicurious,...
	cleanTitle = cleanTitle.replace("at","");
	cleanTitle = cleanTitle.replace("epicurious.com", "");
	
	console.log("Clean title: " + cleanTitle);
	
	//Put each word of the title into an array.  Avoid multiple spaces.
	var titleElements = cleanTitle.split(/ +/g);
	
	//Loop through the json array of picture links.
	var bestCandidateIndex  = 0;  //Default to the first image returned.
	var bestCandidateScore = 0;
	for(i in image)
	{
		//How many words from the title can be found in the image?
		var currentImage = image[i].src.toLowerCase();
		
		//Extract the filename, remove the full path.
		try
		{
			var regexFileNameOnly = /(.*)[\/\\]([^\/\\]+\.\w+)$/;
			var currentFileName = currentImage.match(regexFileNameOnly)[2];
		
			console.log("Examining: " + i + " " + currentFileName);
			var score = 0;
			
			//Give a point for an image being a jpg.  Useful with epicurious.com
			if(currentFileName.indexOf(".jpg") >= 0)
			{
				score++;
			}
			
			//Now search for elements of the page's title in the image.
			for(j in titleElements)
			{
				var currentElement = titleElements[j];
				var elementFoundAt = currentFileName.indexOf(currentElement, 0);
				if(elementFoundAt >= 0)
				{
					score++;
				}
			}
		}
		catch(err)
		{
			console.log("Error at image " + i + "." + err);
		}
		
		//Better score?
		if(score > bestCandidateScore)
		{
			bestCandidateScore = score;
			bestCandidateIndex = i;
		}
	}
	
	console.log("Best candidate index: " + bestCandidateIndex + ". Score: " + bestCandidateScore);
	
	recipePicture = image[bestCandidateIndex].src;
	
	//Check to see if the src tag contained a relative path.
	if(recipePicture.indexOf("http://") < 0)
	{
		var regexURLNoPath = /[^:]+:\/\/[^:\/]+(:[0-9]+)?/i;
		var urlNoPath = recipeURL.match(regexURLNoPath)[0];
		console.log("url with no path: " + urlNoPath);
		recipePicture = urlNoPath + recipePicture;
		console.log("Adjusted image path: " + recipePicture);
	}
}

function assembleScrapedItems(){
	console.log("Assembling scraped items");
	document.getElementById("recipe_url").value = newRecipeURL.value;
	document.getElementById("recipe_image").value = recipePicture;
	document.getElementById("recipe_title").value = recipeTitle;
	
	document.getElementById("newRecipePicture").src  = recipePicture;
	document.getElementById("newRecipeTitle").innerHTML  = recipeTitle;
	$('.add_recipe').show("fast");
}