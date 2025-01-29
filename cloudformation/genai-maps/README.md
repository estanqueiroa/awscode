# Amazon GenAI solutions using SageMaker and Bedrock

This demo shows how to generate Python code to create interactive world maps using Amazon SageMaker, Bedrock, API Gateway and Lambda function.

The solution componentes can be created as Infrastructure as Code (IAC) using the provided CloudFormation templates. Deploy each template as a different CloudFormation stack.

Optional WAF is provided for API gateway protection.

![Alt text](../diagrams/genai-maps.png?raw=true "Diagram Image")

**GenAI prompts:** 

* python code to show map with top 10 visited cities in the world considering last year,
and show city ranking, number of visitors and current weather when I click the city on the map

* modify code to show top 10 latin america cities

* code to show map of top 10 flights around the world in number of passengers last year, click on map to show flight number, company and passengers number

## This updated version includes:

* Sample weather data instead of real API calls
* Better styling for popups and title
* Different colored markers (red for top 3, blue for others)
* Emoji icons in the popup for better visualization
* A cleaner map tile design using CartoDB positron
* Added shadows and improved spacing in the UI elements

When you run this code, it will:

* Create an interactive map showing all 10 cities
* Generate random but realistic weather data for each city
* Show a nicely formatted popup when clicking markers
* Display tooltips on hover
* Include a styled title box

## Key features:

* No Weather API key required (simulated data)
* Completely offline functionality
* Realistic sample data
* Better visual design
* More user-friendly interface

To run this code, you only need:

    
`pip install folium pandas`

    
The output will be an HTML file that you can open in any web browser, showing an interactive map with all the specified features.

## Note

The visitor numbers in this example are illustrative. For actual current data, you would need to update the numbers from a reliable tourism statistics source. Also, be aware that OpenWeatherMap API has rate limits for free accounts.

## Weather API (Optional)

* First, get an API key from OpenWeatherMap:

Sign up at https://openweathermap.org/api
Replace 'your_api_key_here' with your actual API key

* Then Install required packages:
    
`pip install folium pandas requests`

# Flights Map

Features of this map:

* Shows the top 10 busiest flight routes
* Animated flight paths using AntPath
* Different colors for top 3 routes (red) and others (blue)
* Interactive popups showing:
- Route ranking
- Airlines operating the route
- Annual passenger numbers
* Tooltips on hover
* Legend explaining the colors
* Title box with information
* Circle markers for airports

The map shows:

* Flight routes with animated lines
* Airport locations with clickable markers
* Passenger statistics
* Airline information
* Route rankings

**Note:** The passenger numbers are approximate and based on recent data. For the most current statistics, you'd need to consult the latest aviation data sources.

## Amazon SageMaker

To run this code on Amazon SageMaker's JupyterLab, follow these steps:

* Open SageMaker:

Log into your AWS Console
Navigate to Amazon SageMaker
Open JupyterLab

* Create a new notebook:

Click the "+" button in the top left corner
Choose "Python 3 (Data Science)" kernel

* Install required packages:
In the first cell of your notebook, run:
 
`!pip install folium pandas`

* Copy the code from notebook file

Copy the entire code I provided in the previous response
Paste it into a new cell in your JupyterLab notebook

* Run the code:

Click the "Run" button or use Shift+Enter to execute the cell

* View the map:

After running, you should see a message: "Map has been created as 'top_cities_map.html'"
In the file browser on the left, you should see the new 'top_cities_map.html' file
Right-click on this file and select "Open with" -> "HTML Preview"

* Interact with the map:

The map should open in a new tab within JupyterLab
You can now interact with the markers and see the popups


**Additional notes for SageMaker:**

* Ensure your SageMaker notebook instance has internet access to download the map tiles.
* If you're using a SageMaker Studio notebook, the process is similar, but the interface might look slightly different.
* If you want to save the map file permanently, you might need to download it from JupyterLab to your local machine or save it to an S3 bucket.

## CloudFormation

There are two CloudFormation templates so you can deploy Amazon GenAI solutions using Infrastructure as Code (IAC)

**sagemaker-maps.yaml**

This CloudFormation template creates a SageMaker notebook instance with pre-installed code for generating a South America flight routes map. It includes:

* A disclaimer about usage and potential costs
* A SageMaker notebook instance lifecycle configuration
* A SageMaker notebook instance
* An IAM role for SageMaker
* Installation of required Python packages
* Creation of a Jupyter notebook with Python code for creating an interactive map of South American flight routes using Folium

The template sets up the necessary AWS resources and prepares the environment for data visualization of flight routes in South America.

**bedrock-prompt**

This CloudFormation template creates an AWS infrastructure for generating a world population map using Bedrock AI. It includes:

* A Lambda function that sends a prompt to Bedrock's Claude model
* An API Gateway to expose the Lambda function
* IAM roles and permissions for Lambda and Bedrock access
* Optional WAF (Web Application Firewall) protection
* A CloudWatch budget for cost monitoring
* Outputs for easy access to the created resources

The template sets up a serverless architecture that allows users to request AI-generated Python code for creating an interactive world map of the most populated cities.