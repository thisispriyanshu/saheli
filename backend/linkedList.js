class ListNode {
	constructor(coordinates, polyline, distance, duration, htmlInstructions) {
		this.coordinates = coordinates;
		this.polyline = polyline;
		this.distance = distance;
		this.duration = duration;
		this.htmlInstructions = htmlInstructions;
		this.next = null;
	}
}

class LinkedList {
	constructor() {
		this.head = null; // Points to the first node
		this.tail = null; // Points to the last node
		this.length = 0;
	}

	push(coordinates, polyline, distance, duration, htmlInstructions) {
		const node = new ListNode(coordinates, polyline, distance, duration, htmlInstructions);
		if (!this.head) {
			this.head = this.tail = node;
		} else {
			this.tail.next = node;
			this.tail = node;
		}
		this.length++;
	}

	pop() {
		if (this.length === 0) return undefined;
		let current = this.head,
			previous = this.head;
		while (current.next) {
			previous = current;
			current = current.next;
		}
		this.tail = previous;
		this.tail.next = null;
		this.length--;
		if (this.length === 0) this.head = this.tail = null;
		return current;
	}

	unshift(coordinates, polyline, distance, duration, htmlInstructions) {
		const node = new ListNode(coordinates, polyline, distance, duration, htmlInstructions);
		if (this.length === 0) {
			this.head = this.tail = node;
		} else {
			node.next = this.head;
			this.head = node;
		}
		this.length++;
	}

	shift() {
		if (this.length === 0) return undefined;
		const currentHead = this.head;
		this.head = this.head.next;
		this.length--;
		return currentHead;
	}

	get(index) {
		if (index >= this.length || index < 0) return undefined;
		let currentHead = this.head;
		while (index > 0) {
			currentHead = currentHead.next;
			index--;
		}
		return currentHead;
	}

	set(index, coordinates, polyline, distance, duration, htmlInstructions) {
		const node = this.get(index);
		if (node) {
			node.coordinates = coordinates;
			node.polyline = polyline;
			node.distance = distance;
			node.duration = duration;
			node.htmlInstructions = htmlInstructions;
			return true;
		}
		return false;
	}

	insert(index, coordinates, polyline, distance, duration, htmlInstructions) {
		if (index < 0 || index > this.length) return false;
		if (index === this.length) {
			this.push(coordinates, polyline, distance, duration, htmlInstructions);
			return true;
		}
		if (index === 0) {
			this.unshift(coordinates, polyline, distance, duration, htmlInstructions);
			return true;
		}
		const node = new ListNode(coordinates, polyline, distance, duration, htmlInstructions);
		const previous = this.get(index - 1);
		const temp = previous.next;
		previous.next = node;
		node.next = temp;
		this.length++;
		return true;
	}

	remove(index) {
		if (index < 0 || index >= this.length) return undefined;
		if (index === this.length) return this.pop();
		if (index === 0) return this.shift();
		const previous = this.get(index - 1);
		const nodeToRemove = previous.next;
		previous.next = nodeToRemove.next;
		this.length--;
		return nodeToRemove;
	}
}

module.exports = { LinkedList };
