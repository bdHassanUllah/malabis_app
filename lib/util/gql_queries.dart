class GQLQuries {
  // Query to list products with a filter and pagination

  static const String queryQL = r"""
    query {
      listProductsFilter(limit: 100) {
        total_count
        products {
          id
          price
          image
          description {
            name
            description
          }
        }
      }
    }
  """;

  static const String listProductsQuery = r"""
query ListProducts($limit: Int!) {
  listProductsFilter(limit: $limit) {
    total_count
    products {
      id
      price
      image
      description {
        name
        description
      }
    }
  }
}
  """;
  // Query to get promotions
  static const String bannerQuery = r"""
  query {
    listPromotions {
      promotions {
        promotion_image
      }
    }
  }
  """;

  // Query to get a list of categories
  static const String categoryList = r"""
  query {
    listCategoriesFilter {
      categorys {
        id
        image
        description {
          name
        }
      }
    }
  }
  """;

  // Query to find products by category with customer ID
  static const String findByCategory = r"""
  query listProductsFilter($category_id: Int, $customer_id: Int) {
    listProductsFilter(paramsFilter: { category_id: $category_id, customer_id: $customer_id }, limit: 100) {
      total_count
      products {
        is_exisit_favourite
        id
        model
        price
        image
        discount {
          price
        }
        discount_price
        description {
          name
          description
        }
      }
    }
  }
  """;

  // Query to find products by category without customer ID
  static const String findWithoutID = r"""
  query listProductsFilter($category_id: Int) {
    listProductsFilter(paramsFilter: { category_id: $category_id }, limit: 100) {
      total_count
      products {
        is_exisit_favourite
        id
        model
        price
        image
        discount {
          price
        }
        discount_price
        description {
          name
          description
        }
      }
    }
  }
  """;

  // Query to search products
  static const String searchQuery = r"""
  query listProductsFilter($search: String) {
    listProductsFilter(search: $search, limit: 100) {
      total_count
      products {
        id
        price
        image
        discount {
          price
        }
        discount_price
        description {
          name
          description
        }
      }
    }
  }
  """;

  // Query to get pending orders for a customer
  static const String pendingOrdersQuery = r"""
  query listOrdersFilters($customer_id: Int) {
    listOrdersFilters(paramsFilter: { customer_id: $customer_id, order_status_id: 1 }) {
      orders {
        id
        order_status_id
        shipping_address_1
        delivery_date
        total
        order_status {
          id
          name
        }
        order_products {
          name
          product_id
          order_id
          price
          total
        }
      }
    }
  }
  """;

  // Query to get delivered orders for a customer
  static const String deliveredOrderQuery = r"""
  query listOrdersFilters($customer_id: Int) {
    listOrdersFilters(paramsFilter: { customer_id: $customer_id, order_status_id: 5 }) {
      orders {
        id
        order_status_id
        shipping_address_1
        delivery_date
        total
        order_status {
          id
          name
        }
        order_products {
          name
          product_id
          order_id
          price
          total
        }
      }
    }
  }
  """;

  // Query to get canceled orders for a customer
  static const String canceledOrdersQuery = r"""
  query listOrdersFilters($customer_id: Int) {
    listOrdersFilters(paramsFilter: { customer_id: $customer_id, order_status_id: 7 }) {
      orders {
        id
        order_status_id
        shipping_address_1
        delivery_date
        total
        order_status {
          id
          name
        }
        order_products {
          name
          product_id
          order_id
          price
          total
        }
      }
    }
  }
  """;

  // Query to track an order by ID
  static const String trackOrderQuery = r"""
  query getOrder($id: Int!) {
    getOrder(id: $id) {
      order_status_id
      date_added
      date_added_format
      order_totals {
        text
        value
      }
      order_status {
        id
        name
      }
      id
      order_products {
        id
        name
        order_id
        price
        product {
          image
        }
      }
    }
  }
  """;

  // Query to fetch favorite products for a customer
  static const String fetchFavQuery = r"""
  query getFavouriteProductsByCustomer($customer_id: Int!) {
    getFavouriteProductsByCustomer(customer_id: $customer_id) {
      total_count
      products {
        id
        price
        image
        discount {
          price
        }
        discount_price
        description {
          name
          description
        }
      }
    }
  }
  """;

  // Query to get available delivery slots
  static const String availableDeliveryDatesQuery = r"""
  query getAvailableDeliveryDate($deliveryDate: String) {
    listDeliveryAvailableSlots(delivery_date: $deliveryDate) {
      delivery_slots {
        id
        time_slot
        status
      }
      total_count
    }
  }
  """;

  // Query to get delivery fee
  static const String getDeliveryFee = r"""
  query {
    getSetting(key: "delivery_charges_value") {
      id
      key
      value
    }
  }
  """;

  // Query to get FAQs
  static const String getFaq = r"""
  query {
    listFaqs {
      id
      title
      description
    }
  }
  """;
}
