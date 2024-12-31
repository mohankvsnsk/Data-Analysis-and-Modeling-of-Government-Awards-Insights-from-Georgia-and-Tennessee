# Introduction
In this project, our team aimed to conduct an exploratory data analysis and hypothesis testing on a government awards dataset. The collection includes data on a variety of awards, such as program kinds, corporate information, and award amounts. Finding relevant insights by examining possible patterns and links in the data was the main goal.
## Key Findings
### Business Questions: -
1.Which Companies Have Received the Most Awards?
#### Code: -
> award_count <- award_df |> group_by(company, state) |> + summarise(count = n()) |> arrange(desc(count)) |> + filter( count > 35)
Output:

 ![Screenshot 2024-12-31 143837](https://github.com/user-attachments/assets/ec279aa2-a46a-4732-8d1c-d22b103f82f4)

Hypothesis: There is a significant difference in the number of awards received by companies, and some companies are consistently awarded more frequently than others.
2.Is There a Significant Difference in Award Amounts for Socially and Economically Disadvantaged Companies?
#### Code: -
> t_test_result1 <- t.test(disadvantaged, non_disadvantaged)
Output: > t_test_result1
> Welch Two Sample t-test
> data: disadvantaged and non_disadvantaged t = 0.55906, df = 284.33, p-value = 0.5766 alternative hypothesis: true difference in means is not equal to 0 95 percent confidence interval: -41765.62 74902.32 sample estimates: mean of x & mean of y 360331.1 & 343762.8.

Hypothesis: There is a significant difference in the mean award amounts between socially and economically disadvantaged companies (Y) and non-disadvantaged companies (N).

3.How Does the Number of Employees Vary Across Different States?
#### Code: -
> t_test_result3 <- t.test(number_employees ~ state, data = award_clean)
Output:

![image](https://github.com/user-attachments/assets/84bde9de-5f83-41c1-8815-be49b9ceb970)
 
Hypothesis: The mean number of employees varies significantly among different states, suggesting that the state of operation has an impact on the size of companies receiving awards.
### Visualizations: -
1.BarPlot-
The graphic shows how the average number of employees in each state compares to one another. It assists in determining which states have higher or lower average employment rates among the award-winning enterprises.

![image](https://github.com/user-attachments/assets/e2da779e-cc5e-48bb-87d1-6b6aa50e35e9)

2.BoxPlot-The box plot provides information about the distribution of the number of employees per state, including the central tendency, spread, and any outliers. It makes it possible to compare the features of workforce size visually between states.

![image](https://github.com/user-attachments/assets/30721a67-51a9-41a3-a414-9e4ada510f0f)

## Conclusion
Our investigation offers insightful information about the variables affecting the size of government awards. The findings demonstrate how program kinds, regional location, and social and economic deprivation affect parameters connected to awards. Policymakers and other interested parties can use this information to help them make well-informed decisions about government grants.
Citations
1.https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/t.test

2.https://www.datacamp.com/tutorial/t-tests-r-tutorial

## Slide Previews

### Slide 1
![Slide1](https://github.com/user-attachments/assets/ec538c99-e962-499b-a39e-da45beab8822)


---

### Slide 2
![Slide2](https://github.com/user-attachments/assets/1268e4b1-a4e2-4c36-add2-514d65453bef)

---

### Slide 3
![Slide3](https://github.com/user-attachments/assets/5e38314b-66cd-44bd-98f8-41e92231190d)

---

### Slide 4
![Slide4](https://github.com/user-attachments/assets/ba107e3e-37b1-4729-a75c-4e98887d7865)

---

### Slide 5
![Slide5](https://github.com/user-attachments/assets/4b7ee37a-e786-4fc9-9aba-1c697ea41745)

---

### Slide 6
![Slide6](https://github.com/user-attachments/assets/73a0dd50-2414-4b68-87fd-bdf138857d4c)

---

### Slide 7
![Slide7](https://github.com/user-attachments/assets/fa3287e6-b9f3-4615-8cd1-ed3e9a4d8a53)

---

### Slide 8
![Slide8](https://github.com/user-attachments/assets/7109d227-c937-458e-ae42-e0588b5f3e30)

---

### Slide 9
![Slide9](https://github.com/user-attachments/assets/38172259-86fa-4a5f-b951-9d25d87f983d)

---

### Slide 10
![Slide10](https://github.com/user-attachments/assets/c88d5e8b-e673-4668-8938-eb8c5b08813c)

---

### Slide 11
![Slide11](https://github.com/user-attachments/assets/a1ba5d4b-2844-471f-9593-e114aa2a07bc)

---

### Slide 12
![Slide12](https://github.com/user-attachments/assets/a446d3fb-8d77-415b-a540-168ae5932ca0)

---

### Slide 13
![Slide13](https://github.com/user-attachments/assets/0d80abe3-90f7-4f8b-99bd-76c18a71f081)

---

### Slide 14
![Slide14](https://github.com/user-attachments/assets/bfa6128b-3fb0-4bfd-96f5-480c5cf341ba)

---

### Slide 15
![Slide15](https://github.com/user-attachments/assets/a5b9c9fe-8f13-4d13-8152-78e4c37ffd23)

---

### Slide 16
![Slide16](https://github.com/user-attachments/assets/cf7455f4-f69a-4699-96da-350564527b92)

---

### Slide 17
![Slide17](https://github.com/user-attachments/assets/9e66475e-254c-4050-a3ea-098b907585d8)

---

### Slide 18
![Slide18](https://github.com/user-attachments/assets/ab8e97ce-eeb1-4231-a94c-fa6fe1e6b9c5)

---

### Slide 19
![Slide19](https://github.com/user-attachments/assets/f1cffdc1-db63-40d4-8904-8ad38b2854a3)

---

### Slide 20
![Slide20](https://github.com/user-attachments/assets/68ed78d7-4f54-4d06-8de6-902301d984b9)

---

### Slide 21
![Slide21](https://github.com/user-attachments/assets/b46545fe-290f-489d-8808-e59fc13acf05)

---

## How to Use
1. Navigate through the slides to understand the project.
2. For detailed explanations, refer to the accompanying documentation.

---
## License

This project is licensed under the [MIT License](LICENSE).  
You are free to use, modify, and distribute this project, provided that proper attribution is given to the original authors.

---

## Contact
For any questions, please feel free to reach out via the repository's issue tracker.
