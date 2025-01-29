import folium
import pandas as pd

# Create a dataframe with city data (2021 estimates)
data = {
    'City': ['Tokyo', 'Delhi', 'Shanghai', 'São Paulo', 'Mexico City', 
             'Dhaka', 'Cairo', 'Beijing', 'Mumbai', 'Osaka'],
    'Country': ['Japan', 'India', 'China', 'Brazil', 'Mexico', 
                'Bangladesh', 'Egypt', 'China', 'India', 'Japan'],
    'Population': [37.4, 32.9, 27.8, 22.4, 22.1, 
                  21.7, 21.3, 20.9, 20.7, 19.1],  # Population in millions
    'Latitude': [35.6762, 28.7041, 31.2304, -23.5505, 19.4326,
                23.8103, 30.0444, 39.9042, 19.0760, 34.6937],
    'Longitude': [139.6503, 77.1025, 121.4737, -46.6333, -99.1332,
                 90.4125, 31.2357, 116.4074, 72.8777, 135.5023]
}

df = pd.DataFrame(data)

# Create a map centered on the world
world_map = folium.Map(location=[20, 0], zoom_start=2)

# Add markers for each city
for idx, row in df.iterrows():
    # Create popup text
    popup_text = f"""
    <strong>{row['City']}, {row['Country']}</strong><br>
    Population: {row['Population']} million
    """
    
    # Add marker
    folium.CircleMarker(
        location=[row['Latitude'], row['Longitude']],
        radius=row['Population']/2,  # Size of circle based on population
        popup=popup_text,
        color='red',
        fill=True,
        fill_color='red'
    ).add_to(world_map)

# Add a title to the map
title_html = '''
             <h3 align="center" style="font-size:16px">
             <b>Top 10 Most Populous Cities in the World</b>
             </h3>
             '''
world_map.get_root().html.add_child(folium.Element(title_html))

# Save the map
world_map.save('world_largest_cities.html')