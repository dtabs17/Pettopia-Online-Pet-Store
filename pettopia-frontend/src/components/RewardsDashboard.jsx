import { useEffect, useState } from "react";
import { getRewards } from "../services/rewards";

function RewardsDashboard() {
    const [points, setPoints] = useState(0);
    const [transactions, setTransactions] = useState([]);

    useEffect(() => {
        loadRewards();
    }, []);

    async function loadRewards() {
        try {
            const data = await getRewards();
            setPoints(data.totalPoints);
            setTransactions(data.transactions || []);
        } catch (err) {
            console.error(err);
            alert("Failed to fetch rewards");
        }
    }

    return (
        <div className="container mt-4">
            <h2>My Rewards</h2>

            <div className="mb-3">
                <strong>Current Points:</strong> {points}
            </div>

            <h4>Transaction History</h4>
            {transactions.length === 0 ? (
                <p>No transactions yet.</p>
            ) : (
                <table className="table table-dark table-striped">
                    <thead>
                        <tr>
                            <th>Date</th>
                            <th>Type</th>
                            <th>Points</th>
                        </tr>
                    </thead>
                    <tbody>
                        {transactions.map((tx) => (
                            <tr key={tx.id}>
                                <td>{new Date(tx.createdAt).toLocaleString()}</td>
                                <td>{tx.transactionType === "EARN" ? "Earned" : "Redeemed"}</td>
                                <td className={tx.points > 0 ? "text-success" : "text-danger"}>
                                    {tx.points}
                                </td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            )}
        </div>
    );
}

export default RewardsDashboard;
