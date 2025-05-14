// 배송지 목록 모달 창
const btnDeliveryList = document.getElementById('btn-list-address');
const modalDeliveryList = document.getElementById('modal-list-address');
const overalyDeliverList = document.getElementById('overlay-list-address');

btnDeliveryList.addEventListener('click', () => {
	overalyDeliverList.style.display = 'flex';
});

overalyDeliverList.addEventListener('click', () => {
	overalyDeliverList.style.display = 'none';
});

modalDeliveryList.addEventListener('click', (e) => {
	e.stopPropagation();
});

//배송지 선택 
const addressCards = document.querySelectorAll('.address-card');
addressCards.forEach(card => {
	card.addEventListener('click', (e) => {
		if (e.target.tagName.toLowerCase() === 'button') {
			return;
		}

		addressCards.forEach(c => {
			c.classList.remove('selected');
			const textSpan = c.querySelector('.selected-text');
			if (textSpan) {
				textSpan.textContent = ''; // 텍스트 비우기
			}
		});

		card.classList.add('selected');
		const selectedText = card.querySelector('.selected-text');
		if (selectedText) {
			selectedText.textContent = '✓ 선택됨';
		}
		changeAddress(card);
		overalyDeliverList.style.display = 'none';
	});
});

//배송지 반영하여 결제창에 보여주기
function changeAddress(card) {
	const name = card.querySelector('.address-header strong').textContent.trim() || '';
	const comment = card.querySelector('.address-header span').textContent.trim() || '';
	const phone = card.querySelector('.phone').textContent.trim() || '';
	const address = card.querySelector('.address').textContent.trim() || '';
	const detail = card.querySelector('.detail').textContent.trim() || '';
	const number = card.querySelector('.post-number').textContent.trim() || '';

	document.getElementById('receiver-name').innerHTML = name;
	document.getElementById('address-comment').innerHTML = comment;
	document.getElementById('receiver-phone').innerHTML = phone;
	document.getElementById('receiver-address').innerHTML = address;
	document.getElementById('receiver-address-detail').innerHTML = detail;
	document.getElementById('post-number').innerHTML = number;
}

//새 배송지 추가 모달 창 
const btnNewAddress = document.getElementById('btn-new-address');
const overlayEnterAddress = document.getElementById('overlay-enter-address');
const modalEnterAddress = document.getElementById('modal-enter-address');
const btnsEdit = document.querySelectorAll('.btn-edit');
const btnsDelete = document.querySelectorAll('.btn-delete');

btnNewAddress.addEventListener('click', () => {
	overlayEnterAddress.style.display = 'flex';
	inputs = overlayEnterAddress.querySelectorAll('input');
	inputs.forEach(input => { input.value = ''; });
});

//수정버튼 이벤트 리스너 부여
btnsEdit.forEach(btn => {
	btn.addEventListener('click', () => {
		const addressCard = btn.closest('.address-card');
		overlayEnterAddress.style.display = 'flex';
		openEditAddressInfo(addressCard);
	});
});

//수정 함수
function openEditAddressInfo(card) {
	const id = card.querySelector('.address-id').value.trim() || '';
	const name = card.querySelector('.address-header strong').textContent.trim() || '';
	const comment = card.querySelector('.address-header span').textContent.trim() || '';
	const phone = card.querySelector('.phone').textContent.trim() || '';
	const address = card.querySelector('.address').textContent.trim() || '';
	const detail = card.querySelector('.detail').textContent.trim() || '';
	const number = card.querySelector('.post-number').textContent.trim() || '';

	document.getElementById('address-id').value = id;
	document.getElementById('recipient').value = name;
	document.getElementById('phone').value = phone;
	document.getElementById('title').value = comment;
	document.getElementById('address').value = address;
	document.getElementById('detail-address').value = detail;
	document.getElementById('post-number-search').value = number;
}


//배송지 리스트에서 삭제하는 경우
btnsDelete.forEach(btn => {
	btn.addEventListener('click', () => {
		const result = confirm("선택한 배송지를 삭제하시겠습니까?");
		if (result) {
			const card = btn.closest('.address-card');
			const addrId = card.querySelector('.address-id').value;

			// 폼 동적 생성 후 전송 (POST 방식)
			const form = document.createElement('form');
			form.method = 'post';
			form.action = '/movmov/pages/payment/delete-address.jsp';

			const input = document.createElement('input');
			input.type = 'hidden';
			input.name = 'addr_id';
			input.value = addrId;

			form.appendChild(input);
			document.body.appendChild(form);
			form.submit();
		}
	});
});

overlayEnterAddress.addEventListener('click', () => {
	overlayEnterAddress.style.display = 'none';
});

modalEnterAddress.addEventListener('click', (e) => {
	e.stopPropagation();
});

//입력창에 있는 x버튼 누르면 해당 입력창 비우기
const btnClears = document.querySelectorAll('.btn-remove');
btnClears.forEach(btn => {
	btn.addEventListener('click', () => {
		const input = btn.parentElement.querySelector('input');
		if (input) {
			input.value = "";
		}
	});
});

//주소 검색 모달창 띄우기
const btnSearchAddress = document.getElementById('btn-search-address');
const overlaySearchAddress = document.getElementById('overlay-search-address');
const modalSearchAddress = document.getElementById('modal-search-address');
const btnCloseSearch = document.getElementById('btn-close-search');
const list = document.getElementById("result-list");
const keyword = document.getElementById("address-input");

btnSearchAddress.addEventListener('click', () => {
	overlaySearchAddress.style.display = 'flex';
	const guide = document.getElementById("guide");
	guide.style.display = 'block';
	list.style.display = 'none';
	keyword.innerHTML = "";
});

overlaySearchAddress.addEventListener('click', () => {
	overlaySearchAddress.style.display = 'none';
});

btnCloseSearch.addEventListener('click', () => {
	overlaySearchAddress.style.display = 'none';
});

modalSearchAddress.addEventListener('click', (e) => {
	e.stopPropagation();
});

//결제 방법 선택 
const pays = document.querySelectorAll('.account');
pays.forEach(pay => {
	pay.addEventListener('click', (e) => {
		e.preventDefault();
		pays.forEach(c => {
			c.classList.remove('active');
		});
		pay.classList.add('active');
	});
});

//api로 응답 받기
const btnAPI = document.getElementById('btn-api-search');
btnAPI.addEventListener('click', () => {
	searchAddress();
	list.style.display = 'block';
});



async function searchAddress() {
	const keyword = document.getElementById("address-input").value.trim();
	const guide = document.getElementById("guide");
	guide.style.display = 'none';

	if (!keyword) return alert("주소를 입력하세요!");

	const contextPath = window.location.pathname.split("/")[1];
	const list = document.getElementById("result-list");
	list.innerHTML = '';

	try {
		const res = await fetch(`/${contextPath}/api/search-address?keyword=${encodeURIComponent(keyword)}`);
		const data = await res.json();

		if (!data.documents || data.documents.length === 0) {
			list.innerHTML = '<li>검색 결과가 없습니다. 전체 주소를 입력해 주세요.</li>';
			return;
		}

		const roads = data.documents
			.map(d => d.road_address?.address_name)
			.filter(Boolean);

		for (const roadAddress of roads.slice(0, 10)) {
			try {

				const subRes = await fetch(`/${contextPath}/api/search-address?keyword=${encodeURIComponent(roadAddress)}`);
				const subData = await subRes.json();

				if (!subData.documents || subData.documents.length === 0) {
					continue;
				}

				const best = subData.documents[0];
				const road = best.road_address?.address_name || '-';
				const jibun = best.address?.address_name || '-';
				const zone = best.road_address?.zone_no || '없음';

				const li = document.createElement('li');
				li.innerHTML = `
				  <strong>도로명주소:</strong> ${road}<br>
				  <span>지번주소: ${jibun}<br>우편번호: ${zone}</span>
				`;

				li.addEventListener('click', () => {
					document.querySelector('#address-form input[name="address"]').value = road;
					document.querySelector('#address-form input[name="detail"]').value = '';
					document.querySelector('#address-form input[name="zipcode"]').value = zone;

					// 모달 닫기 (옵션)
					document.getElementById('overlay-search-address').style.display = 'none';
				});

				list.appendChild(li);
			} catch (innerErr) {
				console.log(innerErr);
			}
		}

	} catch (err) {
		alert("주소 검색 중 오류가 발생했습니다.");
	}
}
