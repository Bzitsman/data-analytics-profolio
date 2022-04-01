#!/usr/bin/env python
# coding: utf-8

# In[10]:


# First let's import the packages we will use in this project
# You can do this all now or as you need them
import pandas as pd
import numpy as np
import seaborn as sns

import matplotlib.pyplot as plt
import matplotlib.mlab as mlab
import matplotlib
plt.style.use('ggplot')
from matplotlib.pyplot import figure

get_ipython().run_line_magic('matplotlib', 'inline')
matplotlib.rcParams['figure.figsize'] = (12,8)

pd.options.mode.chained_assignment = None


# Now we need to read in the data
df = pd.read_csv(r'C:\Users\Brent\Downloads\movies.csv')


# In[11]:


# Now let's take a look at the data

df.head()


# In[12]:


# We need to see if we have any missing data
# making a loop to do this  

for col in df.columns:
    pct_missing = np.mean(df[col].isnull())
    print('{} - {}%'.format(col, round(pct_missing*100)))


# In[13]:


# looking at the data type of the columns

df.dtypes


# In[17]:


df


# In[46]:


# Are there any Outliers?

df.boxplot(column=['gross'])


# In[ ]:


# Sort by highest grossing movie


# In[26]:


df = df.sort_values(by=['gross'], inplace=False, ascending=False)


# In[20]:


pd.set_option('display.max_rows', None)


# In[22]:


# Drop any duplicates

df['company'].drop_duplicates().sort_values(ascending=False)


# In[24]:


df


# In[28]:


# Scatter plot with Budget vs. Gross Revenue

plt.scatter(x=df['budget'], y=df['gross'])

plt.title('Budget vs Gross Earnings')

plt.xlabel('Gross Earning')

plt.ylabel('Budget for Film')

plt.show()


# In[29]:


df.head()


# In[32]:


# Plot budget vs gross earnings using Seaborn

sns.regplot(x='budget' , y='gross', data=df , scatter_kws={"color": "red"}, line_kws={"color": "blue"})


# In[ ]:


# Looking at Correlation


# In[33]:


df.corr()  #pearson method 


# In[37]:


correlation_matrix = df.corr()

sns.heatmap(correlation_matrix, annot=True)

plt.title('Correlation Matrix for Numric Features')

plt.xlabel('Movie Features')

plt.ylabel('Movie Features')

plt.show()


# In[ ]:


#Looking at the Companies


# In[39]:


# Using factorize - this assigns a random numeric value for each unique categorical value


for col_name in df_numerized.columns:
    if(df_numerized[col_name].dtype == 'object'):
        df_numerized[col_name] = df_numerized[col_name].astype('category')
        df_numerized[col_name] = df_numerized[col_name].cat.codes
        
df_numerized.head()


# In[40]:


correlation_matrix = df_numerized.corr()

sns.heatmap(correlation_matrix, annot=True)

plt.title('Correlation Matrix for Numric Features')

plt.xlabel('Movie Features')

plt.ylabel('Movie Features')

plt.show()


# In[41]:


df_numerized.corr()


# In[43]:


correlation_mat = df_numerized.corr()

corr_pairs = correlation_mat.unstack()

corr_pairs


# In[44]:


sorted_pairs = corr_pairs.sort_values()

sorted_pairs


# In[45]:


# look at the ones that have a high correlation (> 0.5)

high_corr = sorted_pairs[(sorted_pairs) > 0.5]

high_corr


# In[ ]:




