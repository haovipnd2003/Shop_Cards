<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Landing Page</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            header {
                background: #333;
                color: #fff;
                padding: 10px 0;
                text-align: center;
            }
            #Slider {
                position: relative;
                width: 100%;
                overflow: hidden;
            }
            .aspect-ratio-169 {
                position: relative;
                width: 100%;
                padding-bottom: 56.25%; /* 16:9 aspect ratio */
                height: 0;
                overflow: hidden;
            }
            .aspect-ratio-169 img {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                object-fit: cover;
                opacity: 0;
                transition: opacity 1s ease-in-out;
            }
            .aspect-ratio-169 img.active {
                opacity: 1;
            }
            .dot-container {
                position: absolute;
                bottom: 10px;
                left: 50%;
                transform: translateX(-50%);
                display: flex;
                gap: 5px;
            }
            .dot {
                background-color: #bbb;
                border-radius: 50%;
                width: 15px;
                height: 15px;
                cursor: pointer;
            }
            .dot.active {
                background-color: #717171;
            }
            #cta {
                text-align: center;
                margin: 20px 0;
            }
            .cta-button {
                background-color: #007bff;
                color: white;
                padding: 10px 20px;
                text-decoration: none;
                border-radius: 5px;
                font-size: 18px;
            }
            .cta-button:hover {
                background-color: #0056b3;
            }
            footer {
                background: #333;
                color: #fff;
                text-align: center;
                padding: 10px 0;
                position: fixed;
                bottom: 0;
                width: 100%;
            }
            #features {
                text-align: center;
                margin: 40px 0;
                padding: 20px;
            }

            .feature-container {
                display: flex;
                justify-content: space-around;
                margin-bottom: 30px;
            }

            .feature-box {
                flex: 1;
                max-width: 200px;
                padding: 20px;
                border: 1px solid #ddd;
                border-radius: 8px;
                margin: 0 10px;
            }

            .feature-box i {
                font-size: 40px;
                color: #007bff;
                margin-bottom: 15px;
            }

            .feature-box h3 {
                margin: 0;
                font-size: 18px;
            }
            header h1 {
                font-family: 'Montserrat', sans-serif; /* Chọn phông chữ đẹp */
                font-size: 2.5em; /* Kích thước chữ lớn hơn */
                font-weight: bold; /* Chữ đậm */
                color: #f8f9fa; /* Màu chữ sáng */
                text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5); /* Đổ bóng cho văn bản */
                margin: 0;
            }

        </style>
    </head>
    <body>
        <header>
            <h1>Welcome to Shop Card</h1>
        </header>

        <section id="Slider">
            <div class="aspect-ratio-169">
                <img src="image/shop1.jpg" alt="Image 1" class="active">
                <img src="image/the-dien-thoai.jpg" alt="Image 2">
                <img src="https://gamecard.vn/uploads/article/khi-khoang-cach-giua-the-dien-th-2c3bfcc3a1.jpg" alt="Image 3">
            </div>
            <div class="dot-container">
                <div class="dot active"></div>
                <div class="dot"></div>
                <div class="dot"></div>
            </div>
        </section>

        <section id="features">
            <h2>Our Commitment</h2>
            <div class="feature-container">
                <div class="feature-box">
                    <i class="fas fa-shield-alt"></i>
                    <h3>Trustworthy</h3>
                </div>
                <div class="feature-box">
                    <i class="fas fa-gem"></i>
                    <h3>Quality</h3>
                </div>
                <div class="feature-box">
                    <i class="fas fa-bolt"></i>
                    <h3>Fast</h3>
                </div>
            </div>
            <a href="home" class="cta-button">Shop Now</a>
        </section>



        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const slides = document.querySelectorAll('.aspect-ratio-169 img');
                const dots = document.querySelectorAll('.dot');
                let currentIndex = 0;
                const slideInterval = 3000;

                function showSlide(index) {
                    slides.forEach((slide, i) => {
                        slide.classList.remove('active');
                        dots[i].classList.remove('active');
                    });
                    slides[index].classList.add('active');
                    dots[index].classList.add('active');
                }

                function nextSlide() {
                    currentIndex = (currentIndex + 1) % slides.length;
                    showSlide(currentIndex);
                }

                dots.forEach((dot, index) => {
                    dot.addEventListener('click', () => {
                        currentIndex = index;
                        showSlide(currentIndex);
                    });
                });

                showSlide(currentIndex);
                setInterval(nextSlide, slideInterval);
            });
        </script>
    </body>
</html>
