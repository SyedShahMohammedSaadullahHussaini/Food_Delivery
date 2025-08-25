package demo;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import jakarta.servlet.annotation.WebServlet;


@WebServlet("/sendrest")
public class object extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Restaurants> restaurants = new ArrayList<>();

        restaurants.add(new Restaurants(
            "Bowljini-Mix Eat Repeat",
            "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/RX_THUMBNAIL/IMAGES/VENDOR/2025/6/9/c68665d3-1a31-4b58-baf5-81ba0a0945fb_10575.JPG",
            "North Indian, Chinese, Desi...",
            "₹150 for one",
            "24 min",
            "4.2",
            "50% OFF",
            false
        ));

        restaurants.add(new Restaurants(
            "KFC",
            "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/RX_THUMBNAIL/IMAGES/VENDOR/2025/6/9/c68665d3-1a31-4b58-baf5-81ba0a0945fb_10575.JPG",
            "Burger, Fast Food, Rolls...",
            "₹200 for one",
            "25 min",
            "4.2",
            "50% OFF",
            false
        ));

        restaurants.add(new Restaurants(
            "Faasos - Wraps, Rolls & Shawarma",
            "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/RX_THUMBNAIL/IMAGES/VENDOR/2025/6/9/c68665d3-1a31-4b58-baf5-81ba0a0945fb_10575.JPG",
            "Wraps, Rolls, Shawarma",
            "₹100 for one",
            "45 min",
            "4.4",
            "₹125 OFF",
            true
        ));
        restaurants.add(new Restaurants(
                "Faasos - Wraps, Rolls & Shawarma",
                "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/RX_THUMBNAIL/IMAGES/VENDOR/2025/6/9/c68665d3-1a31-4b58-baf5-81ba0a0945fb_10575.JPG",
                "Wraps, Rolls, Shawarma",
                "₹100 for one",
                "45 min",
                "4.4",
                "₹125 OFF",
                true
            ));
        restaurants.add(new Restaurants(
                "Faasos - Wraps, Rolls & Shawarma",
                "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/RX_THUMBNAIL/IMAGES/VENDOR/2025/6/9/c68665d3-1a31-4b58-baf5-81ba0a0945fb_10575.JPG",
                "Wraps, Rolls, Shawarma",
                "₹100 for one",
                "45 min",
                "4.4",
                "₹125 OFF",
                true
            ));
        restaurants.add(new Restaurants(
                "Faasos - Wraps, Rolls & Shawarma",
                "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/RX_THUMBNAIL/IMAGES/VENDOR/2025/6/9/c68665d3-1a31-4b58-baf5-81ba0a0945fb_10575.JPG",
                "Wraps, Rolls, Shawarma",
                "₹100 for one",
                "45 min",
                "4.4",
                "₹125 OFF",
                true
            ));
        restaurants.add(new Restaurants(
                "Faasos - Wraps, Rolls & Shawarma",
                "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/RX_THUMBNAIL/IMAGES/VENDOR/2025/6/9/c68665d3-1a31-4b58-baf5-81ba0a0945fb_10575.JPG",
                "Wraps, Rolls, Shawarma",
                "₹100 for one",
                "45 min",
                "4.4",
                "₹125 OFF",
                true
            ));
        restaurants.add(new Restaurants(
                "Faasos - Wraps, Rolls & Shawarma",
                "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/RX_THUMBNAIL/IMAGES/VENDOR/2025/6/9/c68665d3-1a31-4b58-baf5-81ba0a0945fb_10575.JPG",
                "Wraps, Rolls, Shawarma",
                "₹100 for one",
                "45 min",
                "4.4",
                "₹125 OFF",
                true
            ));
        restaurants.add(new Restaurants(
                "Faasos - Wraps, Rolls & Shawarma",
                "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/RX_THUMBNAIL/IMAGES/VENDOR/2025/6/9/c68665d3-1a31-4b58-baf5-81ba0a0945fb_10575.JPG",
                "Wraps, Rolls, Shawarma",
                "₹100 for one",
                "45 min",
                "4.4",
                "₹125 OFF",
                true
            ));
        restaurants.add(new Restaurants(
                "Faasos - Wraps, Rolls & Shawarma",
                "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/RX_THUMBNAIL/IMAGES/VENDOR/2025/6/9/c68665d3-1a31-4b58-baf5-81ba0a0945fb_10575.JPG",
                "Wraps, Rolls, Shawarma",
                "₹100 for one",
                "45 min",
                "4.4",
                "₹125 OFF",
                true
            ));
        restaurants.add(new Restaurants(
                "Faasos - Wraps, Rolls & Shawarma",
                "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/RX_THUMBNAIL/IMAGES/VENDOR/2025/6/9/c68665d3-1a31-4b58-baf5-81ba0a0945fb_10575.JPG",
                "Wraps, Rolls, Shawarma",
                "₹100 for one",
                "45 min",
                "4.4",
                "₹125 OFF",
                true
            ));
        restaurants.add(new Restaurants(
                "Faasos - Wraps, Rolls & Shawarma",
                "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/RX_THUMBNAIL/IMAGES/VENDOR/2025/6/9/c68665d3-1a31-4b58-baf5-81ba0a0945fb_10575.JPG",
                "Wraps, Rolls, Shawarma",
                "₹100 for one",
                "45 min",
                "4.4",
                "₹125 OFF",
                true
            ));
        restaurants.add(new Restaurants(
                "Faasos - Wraps, Rolls & Shawarma",
                "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/RX_THUMBNAIL/IMAGES/VENDOR/2025/6/9/c68665d3-1a31-4b58-baf5-81ba0a0945fb_10575.JPG",
                "Wraps, Rolls, Shawarma",
                "₹100 for one",
                "45 min",
                "4.4",
                "₹125 OFF",
                true
            ));

//        request.setAttribute("restaurants", restaurants);
//        request.getRequestDispatcher("container.jsp").forward(request, response);
    }
}

	

