// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {PeerToPeerLendingLibrary} from "../libraries/PeerToPeerLendingLibrary.sol";

interface IPeerToPeerLending {
    // Error definitions
    error DepositAmountMustBeGreaterThanZero();
    error InterestRateMustBeGreaterThanZero();
    error InsufficientDepositAmount();
    error InterestRateMismatch();
    error LoanAmountMustBeGreaterThanZero();
    error DurationMustBeGreaterThanZero();
    error LenderDoesNotHaveEnoughTokens();
    error OnlyBorrowerCanRepay();
    error RepaymentAmountMustBeGreaterThanZero();
    error RepaymentExceedsLoanAmount();

    // Event definitions
    event DepositMade(address indexed depositor, uint256 amount, uint256 interestRate);
    event LoanRequested(address indexed borrower, address indexed lender, uint256 amount, uint256 interestRate, uint256 duration);
    event LoanApproved(uint256 indexed loanId, address indexed lender, address indexed borrower, uint256 amount, uint256 interestRate, uint256 duration);
    event RepaymentMade(uint256 indexed loanId, uint256 amount);

    // Function signatures
    function deposit(uint256 _amount, uint256 _interestRate) external;
    function withdraw(uint256 _amount) external;
    function requestLoan(address _lender, uint256 _amount, uint256 _interestRate, uint256 _duration) external;
    function approveLoan(address _borrower, uint256 _amount, uint256 _interestRate, uint256 _duration) external;
    function repayLoan(uint256 _loanId, uint256 _amount) external;
    function calculateTotalAmountDue(uint256 _loanId) external view returns (uint256);
    function getLoanDetails(uint256 _loanId) external view returns (PeerToPeerLendingLibrary.Loan memory);
}
