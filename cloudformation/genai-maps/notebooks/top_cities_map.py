import folium
import pandas as pd
from random import randint, choice

# Create DataFrame with top 10 most visited cities of 2023
data = {
    'rank': range(1, 11),
    'city': ['London', 'Paris', 'Dubai', 'Bangkok', 'Singapore', 
             'New York', 'Tokyo', 'Istanbul', 'Seoul', 'Barcelona'],
    'visitors_millions': [30.9, 27.8, 20.2, 19.8, 19.1, 
                         18.9, 18.4, 16.9, 15.8, 15.2],
    'latitude': [51.5074, 48.8566, 25.2048, 13.7563, 1.3521, 
                 40.7128, 35.6762, 41.0082, 37.5665, 41.3851],
    'longitude': [-0.1278, 2.3522, 55.2708, 100.5018, 103.8198, 
                  -74.0060, 139.6503, 28.9784, 126.9780, 2.1734]
}

df = pd.DataFrame(data)

def get_sample_weather():
    """Generate sample weather data"""
    weather_conditions = [
        'Clear sky', 'Partly cloudy', 'Sunny', 'Light rain',
        'Cloudy', 'Scattered clouds', 'Moderate rain'
    ]
    return {
        'temp': randint(15, 30),  # Temperature between 15-30°C
        'description': choice(weather_conditions),
        'humidity': randint(40, 90)
    }

def get_weather(city):
    #Replace with your API key and API call.
    API_KEY = "YOUR_OPENWEATHERMAP_API_KEY" # Get your own API key from OpenWeatherMap
    url = f"http://api.openweathermap.org/data/2.5/weather?q={city}&appid={API_KEY}&units=metric"
    response = requests.get(url)
    data = response.json()
    if data['cod'] == 200:
      return data['main']['temp']
    else:
      return None
      
# Create a map centered on a middle point
m = folium.Map(location=[30, 0], zoom_start=2, tiles='CartoDB positron')

# Add markers to the map
for idx, row in df.iterrows():
    # Get sample weather
    weather = get_sample_weather()
    
    # Create popup content with styled HTML
    popup_content = f"""
    <div style="font-family: Arial; padding: 5px;">
        <h3 style="color: #2c3e50; margin-bottom: 10px;">{row['city']}</h3>
        <div style="background-color: #f8f9fa; padding: 10px; border-radius: 5px;">
            <p style="margin: 5px 0;"><b>🏆 Rank:</b> #{row['rank']}</p>
            <p style="margin: 5px 0;"><b>👥 Visitors (2023):</b> {row['visitors_millions']} million</p>
            <div style="margin-top: 10px; border-top: 1px solid #dee2e6; padding-top: 10px;">
                <p style="margin: 5px 0;"><b>🌡️ Temperature:</b> {weather['temp']}°C</p>
                <p style="margin: 5px 0;"><b>🌤️ Conditions:</b> {weather['description']}</p>
                <p style="margin: 5px 0;"><b>💧 Humidity:</b> {weather['humidity']}%</p>
            </div>
        </div>
    </div>
    """
    
    # Create marker with custom icon
    folium.Marker(
        location=[row['latitude'], row['longitude']],
        popup=folium.Popup(popup_content, max_width=300),
        tooltip=f"{row['rank']}. {row['city']}",
        icon=folium.Icon(color='red' if row['rank'] <= 3 else 'blue', 
                        icon='info-sign')
    ).add_to(m)

# Add title with styled HTML
title_html = '''
<div style="position: fixed; 
            top: 10px; left: 50px; 
            width: 300px; 
            background-color: white; 
            border-radius: 10px;
            border: 2px solid grey; 
            z-index: 9999; 
            padding: 15px;
            box-shadow: 0 0 10px rgba(0,0,0,0.2);">
    <h3 style="margin: 0; color: #2c3e50; text-align: center;">
        Top 10 Most Visited Cities (2023)
    </h3>
    <p style="margin: 5px 0 0; font-size: 12px; color: #666; text-align: center;">
        Click on markers to see details
    </p>
</div>
'''
m.get_root().html.add_child(folium.Element(title_html))

# Save the map
m.save('top_cities_map.html')

print("Map has been created as 'top_cities_map.html'")
