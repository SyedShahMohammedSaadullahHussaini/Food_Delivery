<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.util.*, com.foodexpress.updatedDTO.OrderItem, com.foodexpress.updatedDTO.User, com.foodexpress.updatedDAO.MenuDAO, com.foodexpress.updatedDTO.MenuItems"%>
<%@ page session="true"%>

<%@ page import="com.foodexpress.updatedDTO.UserAddress, com.foodexpress.updatedDAO.UserAddressDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Payment | FoodExpress</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
body {
	background: #f8f9fa;
	font-family: 'Segoe UI', sans-serif;
}

.container {
	max-width: 1000px;
	margin-top: 40px;
}

.card {
	border-radius: 12px;
	box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
}

.summary-card {
	padding: 20px;
}

.summary-title {
	font-size: 22px;
	font-weight: 700;
	margin-bottom: 20px;
}

.summary-item, .summary-total {
	display: flex;
	justify-content: space-between;
	margin-bottom: 12px;
}

.summary-total {
	border-top: 2px solid #eee;
	padding-top: 15px;
	font-weight: 700;
	font-size: 20px;
}

.payment-option {
	border: 1px solid #ddd;
	padding: 15px;
	border-radius: 10px;
	cursor: pointer;
	transition: 0.3s;
	margin-bottom: 15px;
}

.payment-option:hover {
	border-color: #ff6b35;
	background: #fff7f3;
}

.payment-option input {
	margin-right: 10px;
}

.btn-pay {
	background: #ff6b35;
	border: none;
	color: #fff;
	padding: 14px;
	font-size: 18px;
	font-weight: 600;
	border-radius: 12px;
	width: 100%;
}

.btn-pay:hover {
	background: #e55a2a;
}

.address-section {
	margin-bottom: 25px;
}

.address-card {
	padding: 15px;
	border: 1px solid #ddd;
	border-radius: 10px;
	margin-bottom: 15px;
	cursor: pointer;
	transition: all 0.3s;
}

.address-card:hover {
	border-color: #ff6b35;
}

.address-card.selected {
	border-color: #ff6b35;
	background-color: #fff7f3;
}

.address-label {
	font-weight: 600;
	color: #ff6b35;
	margin-bottom: 5px;
}

.add-address-btn {
	width: 100%;
	padding: 10px;
	text-align: center;
	border: 2px dashed #ddd;
	border-radius: 10px;
	cursor: pointer;
	transition: all 0.3s;
}

.add-address-btn:hover {
	border-color: #ff6b35;
	color: #ff6b35;
}

.modal-backdrop {
	z-index: 1040 !important;
}

.modal {
	z-index: 1050 !important;
}

.address-section {
    margin-bottom: 25px;
    max-height: 300px;   /* Adjust height to fit ~2 addresses + button */
    overflow-y: auto;    /* Enable vertical scrolling */
    padding-right: 5px;  /* Prevent scrollbar overlapping text */
}

/* Optional: style scrollbar (for better UI) */
.address-section::-webkit-scrollbar {
    width: 8px;
}
.address-section::-webkit-scrollbar-thumb {
    background-color: #ccc;
    border-radius: 10px;
}
.address-section::-webkit-scrollbar-thumb:hover {
    background-color: #aaa;
}
</style>
</head>
<body>

	<%
	User u = (User) session.getAttribute("currentUser");
	List<UserAddress> addresses = new ArrayList<>();
	if (u != null) {
		UserAddressDAO dao = new UserAddressDAO();
		try {
			addresses = dao.getAddressesByUser(u.getuId());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	%>
	
	<div class="container">
		<div class="row">
			<div class="col-lg-7">
				<!-- Address Section -->
				<div class="card p-4 mb-4">
					<h3 class="mb-4">
						<i class="fas fa-map-marker-alt"></i> Delivery Address
					</h3>
					
					<div class="address-section" id="addressSection">
					<div class="address-list" >
						<%
						if (addresses != null && !addresses.isEmpty()) {
							for (UserAddress addr : addresses) {
						%>
						<div
							class="address-card <%=(addr.getAddressId() == addresses.get(0).getAddressId()) ? "selected" : ""%>"
							data-address-id="<%=addr.getAddressId()%>">
							<div class="address-label"><%=addr.getLabel()%></div>
							<div><%=addr.getAddress()%></div>
							<div><%=addr.getCity()%>,
								<%=addr.getPincode()%></div>
						</div>
						<%
						}
						} else {
						%>
						<div>No saved addresses. Please add one.</div>
						<%
						}
						%>
					</div>
						
					</div>
					<div class="add-address-btn" data-bs-toggle="modal"
							data-bs-target="#addressModal">
							<i class="fas fa-plus"></i> Add New Address
						</div>
					<div class="modal fade" id="addressModal" tabindex="-1"
						aria-labelledby="addressModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="addressModalLabel">Add New
										Address</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body">
									<form id="addressForm" action="addAddress" method="post">
										<div class="mb-3">
											<label class="form-label">Address Label</label> 
											<select class="form-select" name="label" required>
												<option value="Home">Home</option>
												<option value="Office">Office</option>
												<option value="Other">Other</option>
											</select>
										</div>
										<div class="mb-3">
											<label class="form-label">Full Address</label>
											<textarea class="form-control" name="address" rows="3"
												required placeholder="House no., Building, Street, Area"></textarea>
										</div>
										<div class="row">
											<div class="col-md-6 mb-3">
												<label class="form-label">City</label> <input type="text"
													class="form-control" name="city" required>
											</div>
											<div class="col-md-6 mb-3">
												<label class="form-label">Pincode</label> <input type="text"
													class="form-control" name="pincode" required
													pattern="[0-9]{6}">
											</div>
										</div>
										<div class="modal-footer">
									<button type="button" class="btn btn-secondary"
										data-bs-dismiss="modal">Cancel</button>
									<button type="submit" class="btn btn-primary"
										>Save Address</button>
								</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- Payment Method Section -->
				<div class="card p-4 mb-4">
					<h3 class="mb-4">
						<i class="fas fa-credit-card"></i> Select Payment Method
					</h3>

					<label class="payment-option"> <input type="radio"
						name="paymentMethod" value="CARD" checked> <i
						class="fas fa-credit-card"></i> Credit / Debit Card
					</label>

					<div id="card-details" class="ms-4 mb-4">
						<input type="text" class="form-control mb-3"
							placeholder="Cardholder Name"> <input type="text"
							class="form-control mb-3" placeholder="Card Number">
						<div class="row">
							<div class="col">
								<input type="text" class="form-control mb-3" placeholder="MM/YY">
							</div>
							<div class="col">
								<input type="text" class="form-control mb-3" placeholder="CVV">
							</div>
						</div>
					</div>
					<label class="payment-option"> <input type="radio"
						name="paymentMethod" value="UPI"> <i
						class="fas fa-mobile-alt"></i> UPI Payment
					</label>
					<div id="upi-details" class="ms-4 mb-4" style="display: none;">
						<input type="text" class="form-control mb-3"
							placeholder="Enter UPI ID (e.g. name@upi)">
					</div>

					<label class="payment-option"> <input type="radio"
						name="paymentMethod" value="COD"> <i
						class="fas fa-money-bill-wave"></i> Cash on Delivery
					</label>
				</div>
			</div>

			<div class="col-lg-5">
				<div class="card summary-card">
					<h3 class="summary-title">Order Summary</h3>
					<%
					List<OrderItem> cart = (List<OrderItem>) session.getAttribute("cart");
					User currentUser = (User) session.getAttribute("currentUser");
					double subtotal = 0;
					if (cart != null) {
						for (OrderItem item : cart) {
							subtotal += item.getPriceAtOrder() * item.getQuantity();
						}
					}
					double delivery = 40;
					double taxes = 20;
					double discount = Math.round(subtotal * 0.1);
					double total = subtotal + delivery + taxes - discount;
					%>
					<div class="summary-item">
						<span>Subtotal</span><span>₹<%=subtotal%></span>
					</div>
					<div class="summary-item">
						<span>Delivery Fee</span><span>₹<%=delivery%></span>
					</div>
					<div class="summary-item">
						<span>Taxes & Charges</span><span>₹<%=taxes%></span>
					</div>
					<div class="summary-item">
						<span>Discount</span><span style="color: green;">-₹<%=discount%></span>
					</div>
					<div class="summary-total">
						<span>Total</span><span>₹<%=total%></span>
					</div>

					<form action="payment" method="post">
						 <input type="hidden" id="selectedAddressId" name="addressId" value="<%= (addresses != null && !addresses.isEmpty()) ? addresses.get(0).getAddressId() : "" %>">
						 <input type="hidden" id="paymentMethodInput" name="paymentMethod" value="CARD">
						<button type="submit" class="btn-pay mt-3" href="">
							<i class="fas fa-lock"></i> Pay ₹<%=total%>
						</button>
					</form>
				</div>
			</div>
		</div>
	</div>

	<script>
    // Toggle input sections based on method
    document.querySelectorAll('input[name="paymentMethod"]').forEach(radio => {
        radio.addEventListener('change', (e) => {
            document.getElementById("paymentMethodInput").value = e.target.value;
            document.getElementById('card-details').style.display = 
                document.querySelector('input[value="CARD"]').checked ? 'block' : 'none';
            document.getElementById('upi-details').style.display = 
                document.querySelector('input[value="UPI"]').checked ? 'block' : 'none';
        });
    });

    // Address selection
    function selectAddress(card) {
        document.querySelectorAll('.address-card').forEach(c => c.classList.remove('selected'));
        card.classList.add('selected');
        document.getElementById('selectedAddressId').value = card.dataset.addressId;
    }

    document.querySelectorAll('.address-card').forEach(card => {
        card.addEventListener('click', function() {
            selectAddress(this);
        });
    });

    // Save new address
    let addressCounter = 3; // next available ID
    function saveAddress() {
        const form = document.getElementById('addressForm');
        const label = form.label.value;
        const address = form.address.value;
        const city = form.city.value;
        const pincode = form.pincode.value;

        const newCard = document.createElement('div');
        newCard.className = 'address-card';
        newCard.dataset.addressId = addressCounter++;
        newCard.innerHTML = `
            <div class="address-label">${label}</div>
            <div>${address}</div>
            <div>${city}, ${pincode}</div>
        `;

        newCard.addEventListener('click', function() {
            selectAddress(this);
        });

        document.querySelector('.address-list').appendChild(newCard);


        selectAddress(newCard); // automatically select new address
        form.reset();
        const modal = bootstrap.Modal.getInstance(document.getElementById('addressModal'));
        modal.hide();
    }
</script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 <%-- <!-- // new payment.jsp -->
 
 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page
    import="java.util.*, com.foodexpress.updatedDTO.OrderItem, com.foodexpress.updatedDTO.User, com.foodexpress.updatedDAO.UserAddressDAO, com.foodexpress.updatedDTO.UserAddress"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Payment | FoodExpress</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
body {
    background: #f8f9fa;
    font-family: 'Segoe UI', sans-serif;
}
.container { max-width: 1000px; margin-top: 40px; }
.card { border-radius: 12px; box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08); }
.summary-card { padding: 20px; }
.summary-title { font-size: 22px; font-weight: 700; margin-bottom: 20px; }
.summary-item, .summary-total { display: flex; justify-content: space-between; margin-bottom: 12px; }
.summary-total { border-top: 2px solid #eee; padding-top: 15px; font-weight: 700; font-size: 20px; }
.payment-option { border: 1px solid #ddd; padding: 15px; border-radius: 10px; cursor: pointer; transition: 0.3s; margin-bottom: 15px; }
.payment-option:hover { border-color: #ff6b35; background: #fff7f3; }
.payment-option input { margin-right: 10px; }
.btn-pay { background: #ff6b35; border: none; color: #fff; padding: 14px; font-size: 18px; font-weight: 600; border-radius: 12px; width: 100%; }
.btn-pay:hover { background: #e55a2a; }
.address-section { margin-bottom: 25px; max-height: 300px; overflow-y: auto; padding-right: 5px; }
.address-card { padding: 15px; border: 1px solid #ddd; border-radius: 10px; margin-bottom: 15px; cursor: pointer; transition: all 0.3s; }
.address-card:hover { border-color: #ff6b35; }
.address-card.selected { border-color: #ff6b35; background-color: #fff7f3; }
.address-label { font-weight: 600; color: #ff6b35; margin-bottom: 5px; }
.add-address-btn { width: 100%; padding: 10px; text-align: center; border: 2px dashed #ddd; border-radius: 10px; cursor: pointer; transition: all 0.3s; }
.add-address-btn:hover { border-color: #ff6b35; color: #ff6b35; }
.address-section::-webkit-scrollbar { width: 8px; }
.address-section::-webkit-scrollbar-thumb { background-color: #ccc; border-radius: 10px; }
.address-section::-webkit-scrollbar-thumb:hover { background-color: #aaa; }
</style>
</head>
<body>

<%
User u = (User) session.getAttribute("currentUser");
List<UserAddress> addresses = new ArrayList<>();
if (u != null) {
    UserAddressDAO dao = new UserAddressDAO();
    try { addresses = dao.getAddressesByUser(u.getuId()); }
    catch (Exception e) { e.printStackTrace(); }
}
%>

<div class="container">
    <div class="row">
        <div class="col-lg-7">
            <!-- Address Section -->
            <div class="card p-4 mb-4">
                <h3 class="mb-4"><i class="fas fa-map-marker-alt"></i> Delivery Address</h3>
                <div class="address-section" id="addressSection">
                    <div class="address-list">
                        <%
                        if (addresses != null && !addresses.isEmpty()) {
                            for (UserAddress addr : addresses) {
                        %>
                        <div class="address-card <%=(addr.getAddressId() == addresses.get(0).getAddressId()) ? "selected" : ""%>"
                             data-address-id="<%=addr.getAddressId()%>">
                            <div class="address-label"><%=addr.getLabel()%></div>
                            <div><%=addr.getAddress()%></div>
                            <div><%=addr.getCity()%>, <%=addr.getPincode()%></div>
                        </div>
                        <%
                            }
                        } else {
                        %>
                        <div>No saved addresses. Please add one.</div>
                        <%
                        }
                        %>
                    </div>
                </div>
                <div class="add-address-btn" data-bs-toggle="modal" data-bs-target="#addressModal">
                    <i class="fas fa-plus"></i> Add New Address
                </div>

                <!-- Add Address Modal -->
                <div class="modal fade" id="addressModal" tabindex="-1" aria-labelledby="addressModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="addressModalLabel">Add New Address</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form id="addressForm">
                                    <div class="mb-3">
                                        <label class="form-label">Address Label</label>
                                        <select class="form-select" name="label" required>
                                            <option value="Home">Home</option>
                                            <option value="Office">Office</option>
                                            <option value="Other">Other</option>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Full Address</label>
                                        <textarea class="form-control" name="address" rows="3" required placeholder="House no., Building, Street, Area"></textarea>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">City</label>
                                            <input type="text" class="form-control" name="city" required>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Pincode</label>
                                            <input type="text" class="form-control" name="pincode" required pattern="[0-9]{6}">
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                        <button type="button" class="btn btn-primary" onclick="saveAddress()">Save Address</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Payment Method Section -->
            <div class="card p-4 mb-4">
                <h3 class="mb-4"><i class="fas fa-credit-card"></i> Select Payment Method</h3>

                <label class="payment-option"> <input type="radio" name="paymentMethod" value="CARD" checked> 
                    <i class="fas fa-credit-card"></i> Credit / Debit Card
                </label>
                <div id="card-details" class="ms-4 mb-4">
                    <input type="text" class="form-control mb-3" placeholder="Cardholder Name">
                    <input type="text" class="form-control mb-3" placeholder="Card Number">
                    <div class="row">
                        <div class="col">
                            <input type="text" class="form-control mb-3" placeholder="MM/YY">
                        </div>
                        <div class="col">
                            <input type="text" class="form-control mb-3" placeholder="CVV">
                        </div>
                    </div>
                </div>

                <label class="payment-option"> <input type="radio" name="paymentMethod" value="UPI"> 
                    <i class="fas fa-mobile-alt"></i> UPI Payment
                </label>
                <div id="upi-details" class="ms-4 mb-4" style="display: none;">
                    <input type="text" class="form-control mb-3" placeholder="Enter UPI ID (e.g. name@upi)">
                </div>

                <label class="payment-option"> <input type="radio" name="paymentMethod" value="COD"> 
                    <i class="fas fa-money-bill-wave"></i> Cash on Delivery
                </label>
            </div>
        </div>

        <!-- Order Summary -->
        <div class="col-lg-5">
            <div class="card summary-card">
                <h3 class="summary-title">Order Summary</h3>
                <%
                List<OrderItem> cart = (List<OrderItem>) session.getAttribute("cart");
                double subtotal = 0;
                if (cart != null) {
                    for (OrderItem item : cart) { subtotal += item.getPriceAtOrder() * item.getQuantity(); }
                }
                double delivery = 40, taxes = 20, discount = Math.round(subtotal*0.1), total = subtotal+delivery+taxes-discount;
                %>
                <div class="summary-item"><span>Subtotal</span><span>₹<%=subtotal%></span></div>
                <div class="summary-item"><span>Delivery Fee</span><span>₹<%=delivery%></span></div>
                <div class="summary-item"><span>Taxes & Charges</span><span>₹<%=taxes%></span></div>
                <div class="summary-item"><span>Discount</span><span style="color:green;">-₹<%=discount%></span></div>
                <div class="summary-total"><span>Total</span><span>₹<%=total%></span></div>

                <form action="PaymentServlet" method="post">
                    <input type="hidden" name="addressId" id="selectedAddressId" value="<%= (addresses.size() > 0 ? addresses.get(0).getAddressId() : "") %>">
                    <input type="hidden" name="paymentMethod" id="paymentMethodInput" value="CARD">
                    <button type="submit" class="btn-pay mt-3"><i class="fas fa-lock"></i> Pay ₹<%=total%></button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
document.querySelectorAll('input[name="paymentMethod"]').forEach(radio => {
    radio.addEventListener('change', e => {
        document.getElementById("paymentMethodInput").value = e.target.value;
        document.getElementById('card-details').style.display = document.querySelector('input[value="CARD"]').checked ? 'block' : 'none';
        document.getElementById('upi-details').style.display = document.querySelector('input[value="UPI"]').checked ? 'block' : 'none';
    });
});

function selectAddress(card) {
    document.querySelectorAll('.address-card').forEach(c => c.classList.remove('selected'));
    card.classList.add('selected');
    document.getElementById('selectedAddressId').value = card.dataset.addressId;
}
document.querySelectorAll('.address-card').forEach(card => {
    card.addEventListener('click', function() { selectAddress(this); });
});

// Add new address
let addressCounter = 1000; // temporary ID
function saveAddress() {
    const form = document.getElementById('addressForm');
    const label = form.label.value;
    const address = form.address.value;
    const city = form.city.value;
    const pincode = form.pincode.value;

    const newCard = document.createElement('div');
    newCard.className = 'address-card';
    newCard.dataset.addressId = addressCounter++;
    newCard.innerHTML = `<div class="address-label">${label}</div>
                         <div>${address}</div>
                         <div>${city}, ${pincode}</div>`;
    newCard.addEventListener('click', function() { selectAddress(this); });

    document.querySelector('.address-list').appendChild(newCard);
    selectAddress(newCard);
    form.reset();
    const modal = bootstrap.Modal.getInstance(document.getElementById('addressModal'));
    modal.hide();
}
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
 --%> 